mod cache;
mod pb_message_cache;
pub use pb_message_cache::*;

use crate::android_manager_protocol as pb;

pub use cache::*;

// pub mod local_cache;

pub(crate) trait Key {
    fn get_key(&self) -> String;
}

impl Key for pb::HookInfo {
    fn get_key(&self) -> String {
        format!("{}-{}", self.module_name, self.symbol_name)
    }
}
