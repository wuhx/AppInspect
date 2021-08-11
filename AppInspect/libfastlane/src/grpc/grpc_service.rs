use crate::app_manager_protocol::*;
use crate::jni_channel::AndroidUtil;
use app_manager_protocol::app_manager_server::AppManager;
use tonic::{Request, Response, Status};

use crate::cache::CACHE;

pub mod app_manager_protocol {
    tonic::include_proto!("app_manager");
}

#[derive(Debug, Default)]
pub struct AppManagerImpl {}

#[tonic::async_trait]
impl AppManager for AppManagerImpl {
    async fn list_package(
        &self,
        request: Request<PackageInfoReq>,
    ) -> Result<Response<PackageInfoList>, Status> {
        log::debug!("grpc service: list_package called!");

        let _req = request.into_inner();

        let start = std::time::Instant::now();
        match CACHE.lock().unwrap().list_packages() {
            // match crate::cache::local_cache::list_packages(req) {
            Ok(data) => {
                log::debug!("bench: list_package use {:?}", start.elapsed()); //5s
                Ok(Response::new(data))
                // match AndroidUtil::add_package_state(data) {
                //     Ok(data) => Ok(Response::new(data)),
                //     Err(err) => Err(Status::new(
                //         tonic::Code::Unknown,
                //         format!("add_package_state fail: {:?}", err),
                //     )),
                // }
            }
            Err(err) => {
                let msg = format!("list package fail: {:?}", err);
                log::error!("{}", msg);
                Err(Status::internal(msg))
            }
        }
    }

    // async fn app_control(
    //     &self,
    //     request: Request<AppControlReq>,
    // ) -> Result<Response<AppControlResp>, Status> {
    //     log::trace!("grpc service: app_control called!");
    //
    //     let req = request.into_inner();
    //     let resp = AndroidUtil::app_control(req).unwrap();
    //     Ok(Response::new(resp))
    // }
}
