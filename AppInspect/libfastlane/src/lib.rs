mod jni_channel;

mod cache;
mod grpc;
mod static_server;
mod unzip;

pub use grpc::*;

use jni::objects::JObject;
use jni::sys::jint;
use jni::{JNIEnv, JavaVM};
use once_cell::sync::OnceCell;
use std::ffi::c_void;

// static GRPC_SERVER: Lazy<GrpcServer> = Lazy::new(|| GrpcServer::new("0.0.0.0:10010"));
pub static GLOBAL_JVM: OnceCell<JavaVM> = OnceCell::new();

pub fn get_pkg_name() -> anyhow::Result<String> {
    let file = std::fs::File::open("/proc/self/cmdline")?;
    let reader = std::io::BufReader::new(&file);
    // let mut buffer = Vec::new();
    let mut ret = String::new();
    for line in std::io::BufRead::lines(reader) {
        for c in line.unwrap().chars() {
            if c == '\0' {
                break;
            }
            ret.push(c);
        }
    }

    // reader.read_until(0, &mut buffer)?;//包括最后的0
    // log::debug!("pkg_name[{}]: buf {:?}",buffer.len(), &buffer);
    // let pkg_name = String::from_utf8(buffer)?;
    Ok(ret)
}

#[no_mangle]
pub unsafe extern "C" fn JNI_OnLoad(vm: JavaVM, _reserved: *mut c_void) -> jint {
    //JNI_OnLoad比ctor先执行
    #[cfg(target_os = "android")]
    android_logger::init_once(
        android_logger::Config::default()
            .with_min_level(log::Level::Debug) // limit log level
            .with_tag("AppInspect")
            .with_filter(
                android_logger::FilterBuilder::new()
                    // .parse("debug,lwip_rs::NetIf=trace,bandwidth_rs=error,redq_rs=error,lwip_rs=trace,h2=error")
                    .parse("debug,warp=error,hyper=error,libadb_rs=error,sled=error,lwip_rs::NetIf=error,bandwidth_rs=error,redq_rs=error,lwip_rs=error,h2=error,jni=error")
                    .build(),
            ),
    );
    log_panics::init(); // log panics rather than printing them

    // log::debug!("JNI_OnLoad 1.2, javaVM: {:p}", &vm);
    log::info!("JNI_OnLoad 1.2, {:?}", get_pkg_name());
    start_static_server();

    // root_detect::list_dev();

    let _res = GLOBAL_JVM.set(vm);

    // AndroidVm::init(vm.get_java_vm_pointer());

    // match register_natives(&vm) {
    //     Ok(()) => {},
    //     Err(err) => {
    //         log::error!("fail to register natives: {:?}", err);
    //     }
    // }
    // app_metrics_monitor_thread();
    // app_speed_thread();
    // app_speed_thread();
    // init_package_info_cache_thread();
    // init_adb_thread();

    jni::sys::JNI_VERSION_1_6
}

#[no_mangle]
pub unsafe extern "C" fn Java_com_cloudmonad_inspect_App_start(_env: JNIEnv, _: JObject) -> jint {
    // log::debug!("start server");
    //use localhost
    let res = GrpcServer::start_runtime("0.0.0.0:10010");
    // let res = GrpcServer::start_runtime("127.0.0.1:10010");
    // let res = GrpcServer::start_runtime("/data/data/com.cloudmonad.inspect/files/UNIX_SOCKET");
    // Err(No such file or directory (os error 2))
    log::debug!("start server res: {:?}", res);
    0
}

// fn init_adb_thread() {
//     std::thread::spawn(move || {
//         let res = AndroidUtil::init_adb("127.0.0.1", 5555);
//         log::info!("init_adb_thread: init res {:?}", res.is_ok());
//     });
// }

fn start_static_server() {
    std::thread::spawn(move || {
        let rt = tokio::runtime::Builder::new_multi_thread()
            .enable_all()
            .build()
            .unwrap();
        rt.block_on(async {
            if let Err(err) = static_server::run_server(10020).await {
                log::error!("start static_server fail: {:?}", err);
            }
        });
    });
}
