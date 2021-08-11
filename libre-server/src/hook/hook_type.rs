use crate::GLOBAL_JVM;
use anyhow::Context;
use jni::objects::JString;
use jni::sys::jstring;
use std::hash::Hash;
use std::os::raw::c_char;
use util_rs::ffi::FromCString;

#[allow(non_camel_case_types)]
#[derive(Debug, Clone, Hash)]
pub enum HookType {
    chars,
    value,
    jstring,
}

impl HookType {
    pub fn parse_str(str: &str) -> anyhow::Result<Self> {
        let res = match str {
            "chars" => HookType::chars,
            "value" => HookType::value,
            "jstring" => HookType::jstring,
            _ => {
                log::error!("fail to parse HookType from {}", str);
                HookType::value
            }
        };
        Ok(res)
    }
    pub fn to_string(&self, arg: usize) -> anyhow::Result<String> {
        match self {
            HookType::chars => {
                let arg = arg as *const c_char;
                let res = unsafe { String::from_c_string(arg) };
                Ok(res)
            }
            HookType::jstring => {
                let arg = arg as jstring;
                let vm = GLOBAL_JVM.get().context("GLOBAL_JVM not init!")?;
                let env = vm.get_env()?;
                let cstr = env.get_string_utf_chars(JString::from(arg))?;
                let res = unsafe { String::from_c_string(cstr) };
                Ok(res)
            }
            HookType::value => Ok(arg.to_string()),
            // _ => Ok("unimplemented".to_owned()),
        }
    }
}
