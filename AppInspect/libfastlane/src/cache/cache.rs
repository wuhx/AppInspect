use crate::app_manager_protocol as pb;
use prost::Message;

use crate::jni_channel::AndroidUtil;
use anyhow::Context;
use bytes::Bytes;
use once_cell::sync::Lazy;
use std::collections::HashMap;
use std::sync::Mutex;
use std::time::Instant;

pub static CACHE: Lazy<Mutex<Cache>> = Lazy::new(|| Mutex::new(Cache::new()));

pub struct Cache {
    data: HashMap<String, Bytes>,
    backend: sled::Db,
}
impl Cache {
    pub fn new() -> Self {
        let files_path = if cfg!(target_os = "android") {
            let pkg = crate::get_pkg_name().expect("fail to get_pkg_name ");
            //TODO hardcode here for obf
            format!("/data/data/{}/files", pkg)
        } else {
            ".".to_owned()
        };
        match std::fs::create_dir_all(&files_path) {
            Err(err) => {
                log::error!("fail to create files {:?}", err);
            }
            Ok(_) => {}
        }

        let config = sled::Config::new()
            .use_compression(false)
            .mode(sled::Mode::HighThroughput)
            .flush_every_ms(None)
            .path(format!("{}/.cache", &files_path));

        let backend = config.open().expect("fail to open cache folder!");

        Self {
            data: HashMap::new(),
            backend,
        }
    }

    pub fn update_cache(&mut self, pi: &pb::PackageInfo) {
        let mut buf = Vec::with_capacity(pi.encoded_len());
        if let Err(err) = pi.encode(&mut buf) {
            log::error!("Fail to encode! {:?}", err);
        }
        self.data
            .insert((&pi.pkg_name).to_owned(), Bytes::from(buf));
        // db.flush();
    }

    pub fn update_local_cache(&mut self, resp: &pb::PackageInfoList) -> anyhow::Result<()> {
        let start = Instant::now();
        let mut buf = Vec::with_capacity(resp.encoded_len());
        let _ = resp.encode(&mut buf);
        if let Err(err) = self.backend.insert("pkg_list", buf) {
            log::error!("backend insert fail: {:?}", err);
        }
        if let Err(err) = self.backend.flush() {
            log::error!("backend flush fail: {:?}", err);
        }
        log::debug!("update_local_cache use {:?}", start.elapsed());

        Ok(())
    }

    pub fn update_cache_batch(&mut self, resp: &pb::PackageInfoList) -> anyhow::Result<()> {
        let start = Instant::now();
        for pi in resp.pkg_info_list.iter() {
            self.update_cache(pi);
            // db.flush();
        }
        log::info!("update_cache_batch:  use {:?}", start.elapsed());
        Ok(())
    }

    fn get_pkg_info_cached(&self, pkg_name: &str) -> anyhow::Result<pb::PackageInfo> {
        match self.data.get(pkg_name) {
            Some(bytes) => {
                log::trace!("get_pkg_info_cached:{} cache hit!", pkg_name);
                let resp = pb::PackageInfo::decode(&mut std::io::Cursor::new(bytes))?;
                Ok(resp)
            }
            None => {
                // log::debug!("list_package_cached: cache miss! None");
                anyhow::bail!("get_pkg_info_cached:{} cache miss!", pkg_name);
            }
        }
    }
    fn check_cache_mem(&self) -> bool {
        let res = self.data.len() > 10;
        log::debug!(
            "check_cache_mem:  data.len: {} , res: {}",
            self.data.len(),
            res
        );
        res
    }
    #[allow(dead_code)]
    fn check_cache_local(&self) -> bool {
        let res = self.backend.len() > 0;
        log::debug!(
            "check_cache_local:  backend.len: {} , res: {}",
            self.backend.len(),
            res
        );
        res
    }
    pub fn cache_provisioning_rpc(&mut self) -> anyhow::Result<()> {
        let req = pb::PackageInfoReq {
            not_system_app: false,
            selected_package_list: vec![],
            quick: false,
        };
        let resp = AndroidUtil::list_package(req)?;

        if let Err(err) = self.update_cache_batch(&resp) {
            log::error!("update_cache_batch fail: {:?}", err);
        }
        if let Err(err) = self.update_local_cache(&resp) {
            log::error!("update_local_cache fail: {:?}", err);
        }
        Ok(())
    }
    pub fn cache_provisioning_local(&mut self) -> anyhow::Result<()> {
        match self.backend.get("pkg_list") {
            Ok(Some(bytes)) => {
                log::debug!("cache_provisioning_local: cache hit!");
                let resp: pb::PackageInfoList =
                    pb::PackageInfoList::decode(&mut std::io::Cursor::new(bytes))?;
                if let Err(err) = self.update_cache_batch(&resp) {
                    log::error!("update_cache_batch fail: {:?}", err);
                };
                Ok(())
            }
            Ok(None) => {
                log::debug!("cache_provisioning_local: cache miss! None");
                anyhow::bail!("cache_provisioning_local: cache miss! None");
            }
            Err(err) => {
                log::debug!("cache_provisioning_local: cache error! {:?}", err);
                anyhow::bail!("cache_provisioning_local:cache error {:?}!", err);
                // Ok(false)
            }
        }
    }

    pub fn cache_provisioning(&mut self) {
        log::debug!("cache_provisioning");
        if self.check_cache_mem() {
            log::debug!("cache_provisioning use mem!");
            return;
        } else if self.cache_provisioning_local().is_ok() {
            log::debug!("cache_provisioning use local!");
            return;
        } else {
            log::debug!("cache_provisioning use rpc!");
            if let Err(err) = self.cache_provisioning_rpc() {
                log::error!("cache_provisioning_rpc err: {:?}", err);
            }
            return;
        }
    }

    pub fn get_pkg_info_rpc(pkg_name: &str) -> anyhow::Result<pb::PackageInfo> {
        let req = pb::PackageInfoReq {
            not_system_app: false,
            selected_package_list: vec![pkg_name.to_owned()],
            quick: false,
        };
        let resp = AndroidUtil::list_package(req)?;
        let pkg_info = resp
            .pkg_info_list
            .into_iter()
            .nth(0)
            .context(format!("get_pkg_info {}, empty!", pkg_name))?;
        Ok(pkg_info)
    }

    pub fn list_packages(&mut self) -> anyhow::Result<pb::PackageInfoList> {
        let start = Instant::now();
        self.cache_provisioning();
        log::debug!("cache_provisioning use: {:?}", start.elapsed());

        let quick_req = pb::PackageInfoReq {
            not_system_app: false,
            selected_package_list: vec![],
            quick: true, //快速获取
        };

        let start = Instant::now();
        let quick_resp = AndroidUtil::list_package(quick_req)?;
        log::debug!("list_package_cached quick use: {:?}", start.elapsed());

        let mut resp = vec![];
        for pkg in quick_resp.pkg_info_list {
            match self.get_pkg_info_cached(&pkg.pkg_name) {
                Ok(pi) => {
                    resp.push(pi);
                }
                Err(_) => {
                    log::info!("find new App {:?}", &pkg.pkg_name);
                    let pi = Cache::get_pkg_info_rpc(&pkg.pkg_name)?;
                    self.update_cache(&pi);
                    resp.push(pi);
                }
            }
        }

        let resp_list = pb::PackageInfoList {
            pkg_info_list: resp,
        };

        Ok(resp_list)
    }
}
