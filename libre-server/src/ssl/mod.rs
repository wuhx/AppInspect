use crate::{get_pkg_name, GUM};
use anyhow::Context;
use frida_gum::interceptor::{Interceptor, InvocationContext, InvocationListener};
use pretty_hex::*;
use std::os::raw::c_char;
use util_rs::ffi::FromCString;

#[derive(Debug, Clone, Hash)]
pub struct SslHook {
    buf: Option<*const u8>,
    size: Option<i32>,
}

// int SSL_read(SSL *ssl, void *buf, int num);
impl InvocationListener for SslHook {
    fn on_enter(&mut self, context: InvocationContext) {
        // log::debug!("SslHook on_enter,{:?}", get_pkg_name());

        let buf = context.arg(1) as *const u8;
        let size = context.arg(2) as i32;
        // log::debug!("buf: {:p}, size: {}", buf, size);
        self.buf = Some(buf);
        self.size = Some(size);
    }

    fn on_leave(&mut self, context: InvocationContext) {
        log::debug!("SslHook on_leave,{:?}", get_pkg_name());

        let buf = self.buf;
        let size = self.size;
        let readed = context.return_value() as i32;

        // log::debug!(
        //     "buf: {:?}, size: {:?},size_leave: {:?}, readed: {}",
        //     buf,
        //     size,
        //     size_leave,
        //     readed
        // );
        let cfg = HexConfig {
            title: true,
            width: 32,
            chunk: 16,
            group: 8,
            ..HexConfig::default()
        };

        if readed > 0 {
            let slice = unsafe { std::slice::from_raw_parts(buf.unwrap(), readed as usize) };
            // let file = format!("/data/data/com.cloudmonad.artdemo/dump-{}.data", readed);
            // let res = std::fs::write(&file, slice);
            // log::debug!("write to {}, res: {:?}", &file, res);

            log::debug!("read: {:?}", slice.hex_conf(cfg));
        }
    }
}

pub fn hook() -> anyhow::Result<()> {
    let mut interceptor = Interceptor::obtain(&GUM);

    // /apex/com.android.art/lib64/libopenjdkjvm.so
    let fun_ptr = frida_gum::Module::find_export_by_name(
        Some("/apex/com.android.conscrypt/lib64/libssl.so"),
        "SSL_read",
    )
    .context("unable to find sym of SSL_read")?;
    log::debug!("SSL_read: {:?}", fun_ptr);

    let mut listener = SslHook {
        buf: None,
        size: None,
    };

    interceptor.attach(fun_ptr, &mut listener);
    // Box::leak(listener);

    Ok(())
}
