use crate::{get_hook_list, HookType, GUM};
use anyhow::Context;
use frida_gum::interceptor::{Interceptor, InvocationContext, InvocationListener};

pub struct HooKJvmNativeLoaderListener {
    so_path_loaded: Option<String>,
}

// impl Drop for HooKJvmNativeLoaderListener {
//     fn drop(&mut self) {
//         log::debug!("HooKJvmNativeLoaderListener Drop");
//     }
// }

impl HooKJvmNativeLoaderListener {
    pub fn do_hook() -> anyhow::Result<()> {
        let mut interceptor = Interceptor::obtain(&GUM);

        let mut listener = Box::new(HooKJvmNativeLoaderListener {
            so_path_loaded: None,
        });
        // /apex/com.android.art/lib64/libopenjdkjvm.so
        let fun_ptr =
            frida_gum::Module::find_export_by_name(Some("libopenjdkjvm.so"), "JVM_NativeLoad")
                .context("unable to find sym of JVM_NativeLoad")?;

        let listener_raw: &mut HooKJvmNativeLoaderListener = &mut (*listener);

        interceptor.attach(fun_ptr, listener_raw);
        Box::leak(listener);

        Ok(())
    }
}

impl InvocationListener for HooKJvmNativeLoaderListener {
    fn on_enter(&mut self, context: InvocationContext) {
        // log::debug!("on_enter: HooKJvmNativeLoaderListener");
        let hook_info: &mut Self = unsafe {
            let data =
                frida_gum_sys::gum_invocation_context_get_listener_function_data(context.context);
            std::mem::transmute(data)
        };

        //https://android.googlesource.com/platform/art/+/2e09bc1/runtime/openjdkjvm/OpenjdkJvm.cc#322
        //jstring JVM_NativeLoad(JNIEnv* env,
        //                                  jstring javaFilename,
        //                                  jobject javaLoader,
        //                                  jstring javaLibrarySearchPath)

        let arg1 = context.arg(1);
        let so_path = HookType::jstring.to_string(arg1);
        // log::debug!("HooKJvmNativeLoaderListener: {:?}", so_path);
        if let Ok(path) = so_path {
            hook_info.so_path_loaded = Some(path);
        }
        // let hook_info = unsafe { Box::from_raw(hook_info) };
        // Box::leak(hook_info);
    }

    fn on_leave(&mut self, context: InvocationContext) {
        // log::debug!("on_leave HooKJvmNativeLoaderListener");
        let hook_info: &mut Self = unsafe {
            let data =
                frida_gum_sys::gum_invocation_context_get_listener_function_data(context.context);
            std::mem::transmute(data)
        };
        if let Some(path) = hook_info.so_path_loaded.take() {
            log::debug!("load {}", path);
            // for hook in get_hook_list() {
            //     log::debug!("hook: {:?}", hook);
            // }
            for info in get_hook_list().iter().filter(|h| {
                let mut res = false;
                h.module_name.as_deref().map(|m| {
                    if path.contains(&m) {
                        res = true;
                    }
                });
                res
            }) {
                // log::debug!("HooKJvmNativeLoaderListener hook: {:?}", info);
                // do_hook(info);
                if let Err(err) = info.do_hook() {
                    log::error!("fail to hook: {:?} {:?}", info, err)
                }
            }
        }
    }
}
