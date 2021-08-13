use crate::android_manager_protocol::*;
// use crate::cache::local_cache::*;
// use crate::jni_channel::AndroidUtil;
use android_manager_protocol::android_manager_server::AndroidManager;
// use rusqlite::Connection;
use tonic::{Code, Request, Response, Status};

use crate::cache::{Key, PB_CACHE};
// use crate::cache::{CACHE, PB_CACHE};
use crate::{get_pkg_name, G_STOP_SENDER};
// use anyhow::Error;
// use std::borrow::Borrow;
use anyhow::Context;
use std::io::Write;
// use std::ops::Deref;
// use tokio::runtime::Runtime;

pub mod android_manager_protocol {
    // tonic::include_proto!("android_manager");
    include!("android_manager.rs");
    // pub(crate) const FILE_DESCRIPTOR_SET: &'static [u8] =
    //     tonic::include_file_descriptor_set!("descriptor");
}

#[allow(dead_code)]
fn dump_mem(start: usize, end: usize, name: &str) -> anyhow::Result<String> {
    let pkg_name = get_pkg_name().unwrap();
    let filename = format!(
        "/data/data/{}/dump_{:?}-{:?}.{}",
        pkg_name, start, end, name
    );

    log::debug!("dump mem to:{} ", &filename);

    let ptr = start as *mut u8;
    let size = end - start;
    let mem = unsafe { std::slice::from_raw_parts_mut(ptr, size) };
    let mut file = std::fs::File::create(&filename)?;
    file.write_all(mem)?;
    Ok(filename)
}

#[derive(Debug, Default)]
pub struct AndroidManagerImpl {}

#[tonic::async_trait]
impl AndroidManager for AndroidManagerImpl {
    async fn hook_list_modules(
        &self,
        _request: tonic::Request<HookListModulesReq>,
    ) -> Result<tonic::Response<HookListModulesResp>, tonic::Status> {
        let mut modules = Vec::new();

        fn get_module_name(pathname: Option<String>) -> anyhow::Result<String> {
            let pathname = pathname.context("pathname empty")?;
            if pathname.trim().starts_with("/dev") {
                anyhow::bail!("/dev");
            }
            if pathname.trim().contains("(deleted)") {
                anyhow::bail!("deleted");
            }
            if pathname.trim().starts_with("[") {
                anyhow::bail!("anon memory");
            }
            let res = pathname.split("/").last().context("last empty")?;
            Ok(res.to_owned())
        }

        match crate::hook::proc_map::get_process_maps_self() {
            Ok(result) => {
                for info in result {
                    if !info.is_exec() {
                        //TODO skip
                        continue;
                    }
                    // log::debug!("MapRange: {:?}", info);
                    let module_name = get_module_name(info.pathname.clone());
                    if module_name.is_err() {
                        continue;
                    };
                    let module = ModuleInfo {
                        name: module_name.unwrap(),
                        path: info.pathname.unwrap(),
                        base_addr: info.range_start as u64,
                        size: (info.range_end - info.range_start) as u64,
                    };
                    modules.push(module);
                }
            }
            Err(err) => {
                log::error!("parse proc map fail: {:?}", err);
            }
        }

        //frida module的地址包括map中显示的3列，而不是第一例，导致部分内存不可读
        // let mds = frida_gum::enumerate_modules();
        // log::debug!("find Modules {}", mds.len());
        //
        // let mut modules = Vec::new();
        // for info in mds {
        //     let module = ModuleInfo {
        //         name: info.name,
        //         path: info.path,
        //         base_addr: info.base_addr as u64,
        //         size: info.size as u64,
        //     };
        //     modules.push(module);
        // }

        let resp = HookListModulesResp { modules };
        Ok(Response::new(resp))
    }
    async fn hook_list_symbols(
        &self,
        request: tonic::Request<HookListSymbolsReq>,
    ) -> Result<tonic::Response<HookListSymbolsResp>, tonic::Status> {
        let req = request.into_inner();
        let syms = frida_gum::enumerate_exports(req.module_name.as_str());
        let mut symbols = Vec::new();
        for sym in syms {
            // log::debug!("Symbol: {:?}", sym);
            // if sym.name == "jniRegisterNativeMethods" {
            //     dump_mem(sym.address, 0x1000, sym.name.as_str());
            // }
            let demangle = cpp_demangle::Symbol::new(&sym.name)
                .map(|symbol| symbol.to_string())
                .unwrap_or((&sym.name).to_owned());

            let symbol = HookSymbolInfo {
                module_name: req.module_name.clone(),
                symbol_name: demangle,
                address: sym.address as u64,
                size: sym.size as u64,
            };
            symbols.push(symbol);
        }

        let resp = HookListSymbolsResp { symbols };
        Ok(Response::new(resp))
    }

    async fn hook_info_add(
        &self,
        request: Request<HookInfoAddReq>,
    ) -> Result<Response<HookInfoAddResp>, Status> {
        let info = request.into_inner().info.expect("hook_info_add fail");
        let db = PB_CACHE.lock().unwrap();
        if let Err(err) = db.add(info.get_key().as_str(), &info) {
            log::error!("hook_info_add fail: {:?}", err);
        } else {
            log::debug!("hook_info_add succ: {:?}", &info);
        }

        let resp = HookInfoAddResp { status: 0 };
        Ok(Response::new(resp))
    }

    async fn hook_info_list(
        &self,
        _request: Request<HookInfoListReq>,
    ) -> Result<Response<HookInfoListResp>, Status> {
        // let info = HookInfo {
        //     module_name: "libc.so".to_string(),
        //     symbol_name: "fopen".to_string(),
        //     args: vec![
        //         HookArg {
        //             arg_index: 0,
        //             arg_name: "pathname".to_string(),
        //             arg_type: "char *".to_string(),
        //             hooked: false,
        //         },
        //         HookArg {
        //             arg_index: 1,
        //             arg_name: "mode".to_string(),
        //             arg_type: "char *".to_string(),
        //             hooked: false,
        //         },
        //     ],
        // };
        let db = PB_CACHE.lock().unwrap();
        let hooks = db.list().expect("hook_info_list fail");
        log::debug!("hook_info_list  {:?}!", hooks);

        let resp = HookInfoListResp { hooks: hooks };
        Ok(Response::new(resp))
    }

    async fn hook_server_exit(
        &self,
        request: Request<HookServerExitReq>,
    ) -> Result<Response<HookServerExitResp>, Status> {
        let req = request.into_inner();
        let result = "OK".to_owned();
        log::debug!("hook_server_exit, quit server for {:?}", req.new_pkg_name);
        unsafe {
            let tx = G_STOP_SENDER.take().unwrap();
            let _ = tx.send(());

            // let sd = *(G_STOP_SENDER.get().unwrap());

            // .take().unwrap().unwrap().send(());
        }

        let resp = HookServerExitResp { result };
        Ok(Response::new(resp))
    }

    async fn hook_dump_mem_range(
        &self,
        request: tonic::Request<HookDumpMemRangeReq>,
    ) -> Result<tonic::Response<HookDumpMemRangeResp>, tonic::Status> {
        // log::debug!("hook_dump_mem_range: {:?}", request);
        let req = request.into_inner();

        match dump_mem(req.start as usize, req.end as usize, &req.name) {
            Ok(file) => {
                let resp = HookDumpMemRangeResp {
                    status: 0,
                    dump_file_on_device: file,
                };
                Ok(Response::new(resp))
            }
            Err(err) => {
                let status = Status::new(Code::Internal, format!("dump_mem fail: {:?}", err));
                Err(status)
            }
        }
    }
}
