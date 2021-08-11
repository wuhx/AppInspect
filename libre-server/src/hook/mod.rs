mod hook_function_info;
mod hook_jvm_native_load;
mod hook_type;
pub use hook_function_info::*;

use crate::{android_manager_protocol as pb, get_pkg_name};
use crate::{cache, G_PACKAGE_NAME};
pub use hook_jvm_native_load::*;
pub use hook_type::*;

pub fn load_test_hooks() {
    let infos = vec![
        HookFunctionInfo::new(
            "com.tencent.mm2",
            Some("libc.so"),
            "open",
            vec![(0, HookType::chars), (1, HookType::value)],
        ),
        HookFunctionInfo::new("com.tencent.mm2", Some("libc.so"), "close", vec![]),
        HookFunctionInfo::new(
            "com.tencent.mm2",
            Some("libnativehelper.so"),
            "jniRegisterNativeMethods",
            vec![(1, HookType::chars)],
        ),
        HookFunctionInfo::new(
            "com.tencent.mm2",
            Some("/data/data/com.example.apprs/code_cache/.overlay/base.apk/lib/arm64-v8a/libnative-lib.so"),
            "Java_com_example_apprs_MainActivity_stringFromJNI",
            vec![(2, HookType::jstring)],
        ),
        HookFunctionInfo::new(
            "com.tencent.mm2",
            Some("/apex/com.android.runtime/lib64/bionic/libdl.so"),
            "dlopen",
            vec![(0, HookType::chars)],
        ),
    ];

    for info in infos.clone() {
        add_hook_to_list(info);
    }
}
pub fn load_hook() -> anyhow::Result<i32> {
    let mut count = 0;
    let db = cache::PB_CACHE.lock().unwrap();
    let list = db.list()?;
    // log::debug!("load_hook  list len: {}", list.len());

    fn hook_convert(info: &pb::HookInfo) -> HookFunctionInfo {
        fn arg_convert(args: &Vec<pb::HookArg>) -> Vec<(u32, HookType)> {
            args.iter()
                .filter(|x| x.hooked)
                .map(|arg| {
                    let hook_type: HookType =
                        HookType::parse_str(arg.arg_type.as_str()).expect("fail to parse hooktype");
                    (arg.arg_index as u32, hook_type)
                })
                .collect()
        }
        let args = arg_convert(&info.args);
        // let pkg_name = get_pkg_name().unwrap_or("unknown".to_owned());
        let default = "uninit".to_owned();
        let pkg_name = G_PACKAGE_NAME.get().unwrap();

        HookFunctionInfo::new(
            pkg_name,
            Some(info.module_name.as_str()),
            info.symbol_name.as_str(),
            args,
        )
    }
    list.iter().for_each(|info| {
        // log::debug!("load_hook {:?}", info);
        count += 1;
        let hook_function_info = hook_convert(info);
        add_hook_to_list(hook_function_info);
    });

    Ok(count)
}

pub fn do_hook_all() -> anyhow::Result<()> {
    let hook_list = get_hook_list();

    for hook in hook_list {
        if let Err(err) = hook.do_hook() {
            log::error!("HookInfo: do_hook fail, {:?}", err);
        } else {
            // remove_hook_from_list(&hook);
        }
    }

    if let Err(err) = HooKJvmNativeLoaderListener::do_hook() {
        log::error!("intercept app so load fail: {:?}", err);
    }

    Ok(())
}
