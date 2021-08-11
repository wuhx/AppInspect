// use crate::app_manager_protocol as pb;
use crate::app_manager_protocol::*;
use crate::jni_channel::JniChannel; //for jni_tunnel
// use libadb_rs::util::RunningApp;
// use libadb_rs::{AdbClient, AdbConnection};
use prost::Message;
use std::time::Instant;

#[derive(Debug, Default)]
pub struct AndroidUtil {}

// static ADB: OnceCell<Mutex<AdbConnection>> = OnceCell::new();
// static ADB: OnceCell<AdbConnection> = OnceCell::new();

impl AndroidUtil {
    // pub fn init_adb(ip: &str, port: i32) -> anyhow::Result<AdbConnection> {
    //     let android_target = format!("{}:{}", ip, port);
    //     match AdbClient::new("host::").connect(&android_target) {
    //         Ok(conn) => Ok(conn),
    //         Err(err) => {
    //             anyhow::bail!("adb connect to {} fail,{:?}", android_target, err)
    //         }
    //     }
    // }

    // pub fn add_package_state(
    //     mut package_info_list: PackageInfoList,
    // ) -> anyhow::Result<PackageInfoList> {
    //     log::debug!("add_package_state");
    //     let start = Instant::now();
    //     let mut conn = AndroidUtil::init_adb("127.0.0.1", 5555)?;
    //
    //     // if let Ok(mut conn) = AndroidUtil::init_adb("192.168.0.108", 5555) {
    //     log::debug!("init_adb: {:?}", start.elapsed());
    //
    //     log::debug!("adb init adb res: {:?}", conn);
    //     let start = Instant::now();
    //     let apps = libadb_rs::util::list_running_app(&mut conn)?;
    //
    //     fn check_app(pkg_name: &str, apps: &Vec<RunningApp>) -> bool {
    //         for app in apps {
    //             //fix com.eg.android.AlipayGphone:push
    //             if app.package_name.starts_with(pkg_name) {
    //                 return true;
    //             }
    //         }
    //         return false;
    //     }
    //
    //     log::debug!("list_running_app: {:?}", start.elapsed());
    //     let list: Vec<PackageInfo> = package_info_list
    //         .pkg_info_list
    //         .into_iter()
    //         .map(|mut info| {
    //             if check_app(info.pkg_name.as_str(), &apps) {
    //                 info.running = true;
    //             }
    //
    //             info
    //         })
    //         .collect();
    //
    //     package_info_list.pkg_info_list = list;
    //     // }
    //
    //     Ok(package_info_list)
    // }
    pub fn list_package(req: PackageInfoReq) -> anyhow::Result<PackageInfoList> {
        let api = RequestApi {
            req: Some(request_api::Req::PackageInfoReq(req)),
        };

        // let time = std::time::Instant::now();
        let mut buf = Vec::with_capacity(api.encoded_len());
        if let Err(err) = api.encode(&mut buf) {
            log::error!("api encode fail: {:?}", err);
        }
        // log::debug!("list_package encode req: {:?}", time.elapsed());
        let time = std::time::Instant::now();

        let resp_bytes = JniChannel::jni_direct_buffer_call(&mut buf)?;
        log::debug!("list_package JniChannel call use: {:?}", time.elapsed());

        let time = std::time::Instant::now();

        let resp: PackageInfoList = PackageInfoList::decode(&mut std::io::Cursor::new(resp_bytes))?;
        log::debug!("list_package decode resp: {:?}", time.elapsed());

        Ok(resp)
    }

    // pub fn app_control(req: AppControlReq) -> anyhow::Result<AppControlResp> {
    //     log::debug!("app_control");
    //     let start = Instant::now();
    //     let mut conn = AndroidUtil::init_adb("127.0.0.1", 5555)?;
    //
    //     // if let Ok(mut conn) = AndroidUtil::init_adb("192.168.0.108", 5555) {
    //     log::debug!("init_adb: {:?}", start.elapsed());
    //
    //     // log::debug!("adb init adb res: {:?}", conn);
    //     // let start = Instant::now();
    //     match req.cmd.as_str() {
    //         "restart" => {
    //             libadb_rs::util::kill_app(&mut conn, req.pkg_name.as_str())?;
    //         }
    //         "kill" => {
    //             libadb_rs::util::kill_app(&mut conn, req.pkg_name.as_str())?;
    //         }
    //         "frozen" => {
    //             libadb_rs::util::frozen_app(&mut conn, req.pkg_name.as_str())?;
    //         }
    //         "unfrozen" => {
    //             libadb_rs::util::unfrozen_app(&mut conn, req.pkg_name.as_str())?;
    //         }
    //         "uninstall" => {
    //             libadb_rs::util::uninstall_app(&mut conn, req.pkg_name.as_str())?;
    //         }
    //         "setting" => {
    //             libadb_rs::util::setting_app(&mut conn, req.pkg_name.as_str())?;
    //         }
    //         // "run" => libadb_rs::util::kill_app(),
    //         other => {
    //             log::error!("not support cmd: {}", other);
    //         }
    //     }
    //
    //     let resp = AppControlResp {
    //         pkg_name: req.pkg_name.to_owned(),
    //         status: "OK".to_owned(),
    //     };
    //
    //     Ok(resp)
    // }
}
