use std::os::raw::c_char;
use util_rs::ffi::FromCString;
use std::path::Path;
use ctor::ctor;

#[ctor]
fn init() {
    #[cfg(target_os = "android")]
        android_logger::init_once(
        android_logger::Config::default()
            .with_min_level(log::Level::Debug) // limit log level
            .with_tag("Riru-AppMama-Rlib")
            .with_filter(
                android_logger::FilterBuilder::new()
                    // .parse("debug,lwip_rs::NetIf=trace,bandwidth_rs=error,redq_rs=error,lwip_rs=trace,h2=error")
                    .parse("debug,libadb_rs=error,sled=error,lwip_rs::NetIf=error,bandwidth_rs=error,redq_rs=error,lwip_rs=error,h2=error,jni=error")
                    .build(),
            ),
    );
}
#[no_mangle]
pub extern "C" fn rust_add(a: i32, b: i32) -> i32{
    a + b
}

#[no_mangle]
pub extern fn check_hook_enable(pkg_name: *const c_char) -> bool {

    let pkg_name = unsafe { String::from_c_string(pkg_name)};
    let path = format!("/data/data/{}/.parasite",pkg_name);
    let res = Path::new(&path).exists();
    // log::debug!("check_hook_enable: {} res {}",&path, res);
    res
}