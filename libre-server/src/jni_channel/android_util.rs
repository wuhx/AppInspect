// use crate::android_manager_protocol::*;
// use crate::jni_channel::JniChannel; //for jni_tunnel
// use libadb_rs::util::RunningApp;
// use libadb_rs::{AdbClient, AdbConnection};
// use prost::Message;
// use std::time::Instant;
//
// #[derive(Debug, Default)]
// pub struct AndroidUtil {}
//
// // static ADB: OnceCell<Mutex<AdbConnection>> = OnceCell::new();
// // static ADB: OnceCell<AdbConnection> = OnceCell::new();
//
// impl AndroidUtil {
//     pub fn init_adb(ip: &str, port: i32) -> anyhow::Result<AdbConnection> {
//         let android_target = format!("{}:{}", ip, port);
//         match AdbClient::new("host::").connect(&android_target) {
//             Ok(conn) => Ok(conn),
//             Err(err) => {
//                 anyhow::bail!("adb connect to {} fail,{:?}", android_target, err)
//             }
//         }
//     }
//
// }
