// use crate::android_manager_protocol as pb;
// use crate::jni_channel::AndroidUtil;
// use anyhow::Context;
// use once_cell::sync::Lazy;
// use prost::Message;
// use sled::{Db, Mode};
// use std::collections::HashMap;
// use std::sync::Mutex;
// use std::time::Instant;
//
// pub static MEMORY_CACHE: Lazy<Mutex<HashMap<String, pb::PackageInfo>>> = Lazy::new(|| {
//     let mut m = HashMap::new();
//     m
// });
// pub static LOCAL_CACHE: Lazy<Mutex<sled::Db>> = Lazy::new(|| {
//     let files_path = if cfg!(target_os = "android") {
//         let pkg = crate::get_pkg_name().expect("fail to get_pkg_name ");
//         //TODO hardcode here for obf
//         format!("/data/data/{}/files", pkg)
//     } else {
//         ".".to_owned()
//     };
//     match std::fs::create_dir_all(&files_path) {
//         Err(err) => {
//             log::error!("fail to create files");
//         }
//         Ok(_) => {}
//     }
//
//     let config = sled::Config::new()
//         .use_compression(false)
//         .mode(Mode::HighThroughput)
//         .flush_every_ms(None)
//         .path(format!("{}/.cache", &files_path));
//
//     let db = config.open().expect("fail to open cache folder!");
//
//     Mutex::new(db)
// });
//
// pub fn get_pkg_info_cached(pkg_name: &str, db: &sled::Db) -> anyhow::Result<pb::PackageInfo> {
//     match db.get(pkg_name) {
//         Ok(Some(bytes)) => {
//             log::trace!("get_pkg_info_cached:{} cache hit!", pkg_name);
//             let resp = pb::PackageInfo::decode(&mut std::io::Cursor::new(bytes))?;
//             Ok(resp)
//         }
//         Ok(None) => {
//             // log::debug!("list_package_cached: cache miss! None");
//             anyhow::bail!("get_pkg_info_cached:{} cache miss!", pkg_name);
//         }
//         Err(err) => {
//             // log::debug!("list_package_cached: cache miss! {:?}", err);
//             // get_pkg_info_rpc(req, &db)
//             anyhow::bail!("get_pkg_info_cached:{} cache error {:?}!", pkg_name, err);
//         }
//     }
// }
//
// pub fn get_pkg_info_rpc(pkg_name: &str) -> anyhow::Result<pb::PackageInfo> {
//     let req = pb::PackageInfoReq {
//         not_system_app: false,
//         selected_package_list: vec![pkg_name.to_owned()],
//         quick: false,
//     };
//     let resp = AndroidUtil::list_package(req)?;
//     let pkg_info = resp
//         .pkg_info_list
//         .into_iter()
//         .nth(0)
//         .context(format!("get_pkg_info {}, empty!", pkg_name))?;
//     Ok(pkg_info)
// }
//
// pub fn update_cache_batch(resp: &pb::PackageInfoList) -> anyhow::Result<()> {
//     let mut db = LOCAL_CACHE.lock().unwrap();
//
//     let mut batch = sled::Batch::default();
//     log::debug!(
//         "update_cache_batch total bytes: {}, items: {} ",
//         resp.encoded_len(),
//         resp.pkg_info_list.len()
//     );
//
//     let start = Instant::now();
//     for pi in resp.pkg_info_list.iter() {
//         let mut buf = Vec::with_capacity(pi.encoded_len());
//         pi.encode(&mut buf);
//         batch.insert(pi.pkg_name.as_str(), buf);
//     }
//     log::debug!("update_cache_batch: insert use {:?}", start.elapsed());
//     db.apply_batch(batch)?;
//     log::info!(
//         "update_cache_batch: insert & apply use {:?}",
//         start.elapsed()
//     );
//     Ok(())
//
//     // db.flush();
// }
//
// pub fn update_cache(pi: &pb::PackageInfo, db: &mut sled::Db) {
//     let mut buf = Vec::with_capacity(pi.encoded_len());
//     pi.encode(&mut buf);
//     db.insert(&pi.pkg_name, buf);
//     // db.flush();
// }
//
// pub fn list_packages(req: pb::PackageInfoReq) -> anyhow::Result<pb::PackageInfoList> {
//     let db_inited = {
//         let mut db = MEMORY_CACHE.lock().unwrap();
//         db.len() > 5 //已经有内容
//     };
//
//     // let db_inited = {
//     //     let mut db = LOCAL_CACHE.lock().unwrap();
//     //     if let Ok(Some(_)) = db.get(&"com.android.systemui") {
//     //         true
//     //     } else {
//     //         false
//     //     }
//     // };
//     log::debug!("cache_inited: {}", db_inited);
//
//     if db_inited {
//         list_package_cached()
//     } else {
//         log::info!("Cache provisioning!");
//         let start = Instant::now();
//         let resp = list_package_rpc()?;
//         let mut buf = Vec::with_capacity(resp.encoded_len().clone());
//         resp.encode(&mut buf);
//
//         std::thread::spawn(|| {
//             let resp_copy: pb::PackageInfoList =
//                 pb::PackageInfoList::decode(&mut std::io::Cursor::new(buf))
//                     .expect("fail to decode resp_copy!");
//
//             if let Err(err) = update_cache_batch(&resp_copy) {
//                 log::error!("fail to update cache batch: {:?}", err)
//             }
//         });
//
//         log::info!("Cache provisioning use {:?}", start.elapsed());
//         Ok(resp)
//     }
// }
// pub fn list_package_rpc() -> anyhow::Result<pb::PackageInfoList> {
//     let req = pb::PackageInfoReq {
//         not_system_app: false,
//         selected_package_list: vec![],
//         quick: false,
//     };
//     let resp = AndroidUtil::list_package(req)?;
//     Ok(resp)
// }
//
// pub fn list_package_cached() -> anyhow::Result<pb::PackageInfoList> {
//     let mut db = LOCAL_CACHE.lock().unwrap();
//
//     let quickReq = pb::PackageInfoReq {
//         not_system_app: false,
//         selected_package_list: vec![],
//         quick: true, //快速获取
//     };
//
//     let start = Instant::now();
//     let quickResp = AndroidUtil::list_package(quickReq)?;
//     log::debug!("list_package_cached quick use: {:?}", start.elapsed());
//
//     let mut resp = vec![];
//     for pkg in quickResp.pkg_info_list {
//         match get_pkg_info_cached(&pkg.pkg_name, &db) {
//             Ok(pi) => {
//                 resp.push(pi);
//             }
//             Err(_) => {
//                 log::info!("find new App {:?}", &pkg.pkg_name);
//                 let pi = get_pkg_info_rpc(&pkg.pkg_name)?;
//                 update_cache(&pi, &mut db);
//                 resp.push(pi);
//             }
//         }
//     }
//
//     let resp_list = pb::PackageInfoList {
//         pkg_info_list: resp,
//     };
//
//     Ok(resp_list)
// }
