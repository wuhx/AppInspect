mod uds_server;
mod grpc;
mod cmd;

use jni::sys::jint;
use std::ffi::c_void;
use jni::JavaVM;


fn log_init() {
    //JNI_OnLoad比ctor先执行
    #[cfg(target_os = "android")]
        android_logger::init_once(
        android_logger::Config::default()
            .with_min_level(log::Level::Debug) // limit log level
            .with_tag("LibJsu")
            .with_filter(
                android_logger::FilterBuilder::new()
                    // .parse("debug,lwip_rs::NetIf=trace,bandwidth_rs=error,redq_rs=error,lwip_rs=trace,h2=error")
                    .parse("debug,libadb_rs=error,sled=error,lwip_rs::NetIf=error,bandwidth_rs=error,redq_rs=error,lwip_rs=error,h2=error,jni=error")
                    .build(),
            ),
    );
    log_panics::init(); // log panics rather than printing them
}

#[no_mangle]
pub unsafe extern "C" fn JNI_OnLoad(_vm: JavaVM, _reserved: *mut c_void) -> jint {

    log_init();
    log::debug!("JNI_OnLoad: 1.0.2");
    let bind_addr = "0.0.0.0:65535";
    start_server(bind_addr.to_owned());


    jni::sys::JNI_VERSION_1_6
}

fn start_server(bind_addr: String) {
    std::thread::spawn(move || {
        log::debug!("start_server: {}",bind_addr);
        if let Err(err) = grpc::grpc_server::GrpcServer::start_runtime(&bind_addr) {
            log::debug!("start server fail: {:?}",err);
        }
    });
}