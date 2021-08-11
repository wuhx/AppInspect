mod android_vm;
pub use android_vm::*;

mod cache;
mod jni_channel;

mod hook;
pub use hook::*;

mod grpc;
pub use grpc::*;

use android_logger::{Config, FilterBuilder};
use frida_gum::Gum;
use jni::objects::JObject;
use jni::sys::jint;
use jni::{JNIEnv, JavaVM};
use log::Level;
use once_cell::sync::{Lazy, OnceCell};
use std::ffi::c_void;
use std::os::raw::c_char;
use std::path::Path;
use util_rs::ffi::FromCString;

static GUM: Lazy<Gum> = Lazy::new(|| unsafe { Gum::obtain() });
pub static G_PACKAGE_NAME: OnceCell<String> = OnceCell::new();

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
        Config::default()
            .with_min_level(Level::Debug) // limit log level
            .with_tag("Riru-AppInspect-SRV")
            .with_filter(
                FilterBuilder::new()
                    // .parse("debug,lwip_rs::NetIf=trace,bandwidth_rs=error,redq_rs=error,lwip_rs=trace,h2=error")
                    .parse("debug,libadb_rs=error,sled=error,lwip_rs::NetIf=error,bandwidth_rs=error,redq_rs=error,lwip_rs=error,h2=error,jni=error")
                    .build(),
            ),
    );
    log_panics::init(); // log panics rather than printing them

    if _reserved.is_null() {
        log::debug!("JNI_OnLoad 1.5, uid: {:?}", libc::getuid());
    } else {
        let pkg_name = String::from_c_string(_reserved as *const u8);

        log::debug!(
            "JNI_OnLoad 1.5, pkg_name: {}, uid: {:?}",
            &pkg_name,
            libc::getuid()
        );

        let _ = G_PACKAGE_NAME.set(pkg_name);
    };

    // log::debug!("JNI_OnLoad 1.2, javaVM: {:p}", &vm);

    Lazy::force(&GUM);

    // AndroidVm::from_raw(vm.get_java_vm_pointer());
    let _res = GLOBAL_JVM.set(vm);

    // let show_admin_ui = false;
    start_admin_ui();
    // load_test_hooks();
    if let Err(err) = load_hook() {
        log::error!("load_hook: {:?}", err);
    };
    if let Err(err) = do_hook_all() {
        log::error!("do_hook fail: {:?}", err);
    }

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
pub unsafe extern "C" fn Java_com_cloudmonad_ran_App_start(_env: JNIEnv, _: JObject) -> jint {
    // log::debug!("start server");
    let res = GrpcServer::start_runtime("0.0.0.0:10015");
    // let res = GrpcServer::start_runtime("127.0.0.1:10010");
    // let res = GrpcServer::start_runtime("/data/data/com.cloudmonad.ran.debug/files/UNIX_SOCKET");
    // Err(No such file or directory (os error 2))
    log::debug!("start server res: {:?}", res);
    0
}

fn start_admin_ui() {
    std::thread::spawn(move || {
        let res = GrpcServer::start_runtime("0.0.0.0:10015");
        log::debug!("start server res: {:?}", res);
    });
}

#[no_mangle]
pub extern "C" fn check_hook_enable(pkg_name: *const c_char) -> bool {
    let pkg_name = unsafe { String::from_c_string(pkg_name) };
    let path = format!("/data/data/{}/.parasite", pkg_name);
    let res = Path::new(&path).exists();
    // log::debug!("check_hook_enable: {} res {}",&path, res);
    res
}
