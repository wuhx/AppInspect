use tonic::{Request, Response, Status};
use crate::grpc::grpc_services::root_manager_server::RootManager;

// pub mod root_manager_protocol {
    // tonic::include_proto!("android_manager");
    include!("root_manager.rs");
    // pub(crate) const FILE_DESCRIPTOR_SET: &'static [u8] =
    //     tonic::include_file_descriptor_set!("descriptor");
// }


#[derive(Debug, Default)]
pub struct RootManagerImpl {}

#[tonic::async_trait]
impl RootManager for RootManagerImpl {

    async fn run_root_cmd(&self, request: Request<RunRootCmdReq>) -> Result<Response<RunRootCmdResp>, Status> {
        let cmd = request.into_inner().cmd;
        let result = crate::cmd::run_cmd(cmd.clone()).await.unwrap_or("run cmd fail!".to_owned());
        log::debug!("run_root_cmd: recv: {}, resp: {}",&cmd, &result);
        let resp = RunRootCmdResp { result };
        Ok(Response::new(resp))
    }
}
