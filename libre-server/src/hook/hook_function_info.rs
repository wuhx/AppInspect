use crate::{HookType, GUM};
use anyhow::Context;
use frida_gum::interceptor::{Interceptor, InvocationContext, InvocationListener};
use once_cell::sync::Lazy;
use serde::{Deserialize, Serialize};
use std::hash::{Hash, Hasher};
use std::sync::Mutex;

#[derive(Deserialize, Serialize)]
pub struct ArgResult {
    name: String,
    value: String,
}

#[derive(Deserialize, Serialize)]
pub struct HookResult {
    pkg_name: String,
    module_name: Option<String>,
    function_name: String,
    args: Vec<ArgResult>,
}

#[derive(Debug, Clone, Hash)]
pub struct HookFunctionInfo {
    pkg_name: String,
    pub(crate) module_name: Option<String>,
    pub(crate) function_name: String,
    args: Vec<(u32, HookType)>,
}

impl HookFunctionInfo {
    pub fn new(
        pkg_name: &str,
        module_name: Option<&str>,
        function_name: &str,
        args: Vec<(u32, HookType)>,
    ) -> Self {
        Self {
            pkg_name: pkg_name.to_owned(),
            module_name: module_name.map(|x| x.to_owned()),
            function_name: function_name.to_owned(),
            args,
        }
    }
    pub fn get_hash(&self) -> u64 {
        let mut hasher = std::collections::hash_map::DefaultHasher::new();
        self.hash(&mut hasher);
        hasher.finish()
    }

    pub fn do_hook(&self) -> anyhow::Result<()> {
        let mut interceptor = Interceptor::obtain(&GUM);

        let mut info = Box::new(self.clone());

        let fun_ptr = frida_gum::Module::find_export_by_name(
            info.module_name.as_deref(),
            info.function_name.as_str(),
        )
        .context(format!("fail to find ptr for: {:?}", info))?;
        log::debug!("do_hook: {:?} {:?}", fun_ptr, &info);

        // let ptr: &mut HookInfo = &mut (*info);
        let ptr: &mut HookFunctionInfo = unsafe { std::mem::transmute(&mut (*info)) };

        interceptor.attach(fun_ptr, ptr);

        Box::leak(info);

        Ok(())
    }
}
impl Drop for HookFunctionInfo {
    fn drop(&mut self) {
        log::debug!("HookInfo drop");
    }
}

impl InvocationListener for HookFunctionInfo {
    fn on_enter(&mut self, ctx: InvocationContext) {
        // log::debug!("HookInfo enter {:?}", self); //不要尝试这样，你和代码都会崩溃
        let hook_info: &Self = unsafe {
            let data =
                frida_gum_sys::gum_invocation_context_get_listener_function_data(ctx.context);
            std::mem::transmute(data)
        };
        // log::debug!("HookInfo enter {:p}", hook_info);
        // log::debug!("HookInfo enter {:?}", hook_info.function_name);
        // let function_name = hook_info.function_name.clone();
        // log::debug!("HookInfo enter {}", function_name);

        let mut args: Vec<ArgResult> = Vec::new();
        for (index, hook_type) in hook_info.args.clone() {
            let value = ctx.arg(index);
            let res = hook_type.to_string(value).unwrap_or("readfail".to_owned());
            let arg = ArgResult {
                name: format!("arg{}", index),
                value: res,
            };
            args.push(arg);
            // log::debug!(
            //     "HookInfo: {:?} {} arg {}: {:?}",
            //     hook_info.module_name.as_ref().unwrap_or(&"".to_owned()),
            //     hook_info.function_name,
            //     index,
            //     res
            // );
        }
        let res = HookResult {
            pkg_name: hook_info.pkg_name.clone(),
            module_name: hook_info.module_name.clone(),
            function_name: hook_info.function_name.clone(),
            args,
        };
        let json = serde_json::to_string_pretty(&res).unwrap();

        log::debug!("{}", json);
    }

    fn on_leave(&mut self, _ctx: InvocationContext) {}
}

static HOOKS: Lazy<Mutex<Vec<HookFunctionInfo>>> = Lazy::new(|| {
    let list = Vec::new();
    Mutex::new(list)
});

pub fn get_hook_list() -> Vec<HookFunctionInfo> {
    HOOKS.lock().unwrap().clone()
}

pub fn remove_hook_from_list(info: &HookFunctionInfo) {
    log::debug!("remove_hook_from_list: {:?}", info);
    let mut hooks = HOOKS.lock().unwrap();
    let mut remove_index = 0;
    for (i, hook) in hooks.iter().enumerate() {
        if hook.get_hash() == info.get_hash() {
            remove_index = i;
            break;
        }
    }
    hooks.remove(remove_index);
}

pub fn add_hook_to_list(info: HookFunctionInfo) {
    log::debug!("add_hook_to_list: {:?}", info);
    let mut hooks = HOOKS.lock().unwrap();
    hooks.push(info);
}
