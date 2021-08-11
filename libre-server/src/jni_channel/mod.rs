use crate::AndroidVm;
use jni::objects::{JByteBuffer, JObject, JValue};
mod android_util;
pub use android_util::*;

pub struct JniChannel {}
impl JniChannel {
    #[allow(dead_code)]
    pub fn jni_direct_buffer_call(req: &mut [u8]) -> anyhow::Result<Vec<u8>> {
        let vm = AndroidVm::get()?;
        let env = vm.get_env()?;
        // log::debug!("JniChannel find env: {:p}", &env);

        // log::debug!(
        //     "jni_direct_buffer_call thread: {:?} ",
        //     std::thread::current()
        // );
        // log::debug!("jni_direct_buffer_call find env");

        //TODO cache this
        let clz = env.find_class("com/defyun/channel/UiChannel")?;
        // log::debug!("jni_direct_buffer_call find clz: {:?}", clz);

        let signature = "(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;";
        // let  req = vec![5u8; 198];
        let arg = env.new_direct_byte_buffer(req).unwrap();

        let bb = env
            .call_static_method(
                clz,
                "jniMethodCall",
                signature,
                &[JValue::Object(JObject::from(arg))],
            )?
            .l()?;
        let res = env.get_direct_buffer_address(JByteBuffer::from(bb))?;
        let mut buf = vec![0u8; res.len()]; //TODO avoid copy data here
        buf.copy_from_slice(res);

        Ok(buf)
    }
}
