use crate::{android_manager_protocol as pb, G_PACKAGE_NAME};
use prost::Message;

use once_cell::sync::Lazy;
use std::sync::Mutex;

pub static PB_CACHE: Lazy<Mutex<PbMessageCache>> = Lazy::new(|| Mutex::new(PbMessageCache::new()));

pub struct PbMessageCache {
    db: sled::Db,
}
impl PbMessageCache {
    pub fn new() -> Self {
        let files_path = if cfg!(target_os = "android") {
            match G_PACKAGE_NAME.get() {
                Some(pkg_name) => {
                    format!("/data/data/{}", pkg_name)
                }
                None => "/data/local/tmp".to_owned(),
            }
        } else {
            ".".to_owned()
        };
        match std::fs::create_dir_all(&files_path) {
            Err(_err) => {
                log::error!("fail to create files");
            }
            Ok(_) => {}
        }

        let config = sled::Config::new()
            .use_compression(false)
            .mode(sled::Mode::HighThroughput)
            .flush_every_ms(Some(100))
            .path(format!("{}/.pbcache", &files_path));

        let db = config
            .open()
            .expect(format!("fail to open cache folder: {}!", &files_path).as_str());

        Self { db }
    }

    pub fn add(&self, key: &str, msg: &pb::HookInfo) -> anyhow::Result<()> {
        let mut buf = Vec::with_capacity(msg.encoded_len());
        msg.encode(&mut buf)?;
        self.db.insert(key, buf)?;
        self.db.flush()?;
        Ok(())
    }
    pub fn list(&self) -> anyhow::Result<Vec<pb::HookInfo>> {
        let res: Vec<pb::HookInfo> = self
            .db
            .iter()
            .values()
            .map(|item| {
                let item = item.unwrap();
                let msg = pb::HookInfo::decode(&mut std::io::Cursor::new(item)).unwrap();
                msg
            })
            .collect();
        log::debug!("PbMessageCache find {} hooks", res.len());

        Ok(res)
    }

    #[allow(dead_code)]
    pub fn get(&self, key: &str) -> anyhow::Result<Option<pb::HookInfo>> {
        match self.db.get(key) {
            Ok(Some(bytes)) => {
                let msg = pb::HookInfo::decode(&mut std::io::Cursor::new(bytes))?;
                Ok(Some(msg))
            }
            Ok(None) => Ok(None),
            Err(err) => {
                anyhow::bail!("PbMessageCache get {} ,fail {:?}!", key, err);
            }
        }
    }
}
