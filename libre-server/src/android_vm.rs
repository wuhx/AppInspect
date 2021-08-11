use jni::{JNIEnv, JavaVM};
use once_cell::sync::{Lazy, OnceCell};

//https://gist.github.com/wuhx/34a8e21296674d878ad7796b3ff87cc3

pub static GLOBAL_JVM: OnceCell<JavaVM> = OnceCell::new();

static mut G_VM: usize = 0;

pub struct AndroidVm {
    pub vm: JavaVM,
}

impl AndroidVm {
    pub fn get_env(&self) -> anyhow::Result<JNIEnv> {
        let env = self.vm.attach_current_thread_permanently();
        match env {
            Ok(env) => {
                // log::debug!("get env succ");
                Ok(env)
            }
            Err(err) => {
                log::error!("get env fail: {:?}", err);
                anyhow::bail!("get env fail");
            }
        }
        // log::debug!("get env: {:?}",env);
        // self.vm.attach_current_thread()?;
        // OK(env?);
    }
    pub fn get() -> anyhow::Result<&'static AndroidVm> {
        unsafe {
            if G_VM == 0 {
                let thread_id = std::thread::current().id();
                log::debug!("[thread:{:?}] AndroidVm.get()", thread_id);
                anyhow::bail!("AndroidVm not inited!");
            } else {
                static ANDROID_VM: Lazy<AndroidVm> =
                    Lazy::new(|| unsafe { AndroidVm::from_raw(G_VM).expect("vm cast fail!") });
                Ok(&ANDROID_VM)
            }
        }
    }
    pub fn init(vm: *mut jni::sys::JavaVM) {
        let vm_ptr = vm as *const _ as usize;
        let thread_id = std::thread::current().id();
        log::debug!("[thread:{:?}] AndroidVm.init()", thread_id);
        log::debug!("AndroidVm init with: {:x}", vm_ptr);
        unsafe {
            G_VM = vm_ptr;
        }
    }

    pub fn from_raw(ptr: usize) -> anyhow::Result<Self> {
        let vm = unsafe {
            let ptr = ptr as *mut jni::sys::JavaVM;
            log::debug!("AndroidVm cast vm: {:p}", ptr);
            JavaVM::from_raw(ptr)
        }?;
        Ok(Self { vm })
    }

    //获取签名，故意混淆
    pub fn get_app_name(&self) -> anyhow::Result<String> {
        let _env = self.vm.get_env()?;
        Ok("".to_owned())
    }
}
