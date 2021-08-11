
use once_cell::sync::Lazy;
use std::net::SocketAddr;
use std::ops::Deref;
use tokio::runtime::Runtime;
use tonic::{metadata::MetadataValue, transport::Server};
use tonic::{Request, Status};
use crate::grpc::grpc_services::RootManagerImpl;
use crate::grpc::grpc_services::root_manager_server::{RootManagerServer, RootManager};

static TOKEN: Lazy<String> = Lazy::new(|| {
    // let tk = get_pkg_name().expect("Fail to Unify");
    let tk = "my token".to_owned();

    tk
});
#[derive(Debug)]
pub struct GrpcServer {
    // thread: std::thread::JoinHandle<()>,
}
impl GrpcServer {

    pub fn start_runtime(bind_addr: &str) -> anyhow::Result<()> {
        let rt = tokio::runtime::Builder::new_multi_thread()
            .enable_all()
            .build()?;

        #[allow(dead_code)]
        fn check_auth(req: Request<()>) -> Result<Request<()>, Status> {
            // let token: &'static str = env!("GRPC_TOKEN");

            let token = TOKEN.deref();

            log::debug!("token from GRPC_TOKEN: {}", token);

            let token = format!("Bearer {}", token);

            let token = MetadataValue::from_str(token.as_str()).unwrap();

            match req.metadata().get("authorization") {
                Some(t) if token == t => Ok(req),
                _ => Err(Status::unauthenticated("No valid auth token")),
            }
        }

        let root_manager_impl = RootManagerImpl::default();
        // let server = AndroidManagerServer::with_interceptor(android_manager_impl, check_auth);
        let server = RootManagerServer::new(root_manager_impl);
        let addr: SocketAddr = bind_addr.parse()?;

        GrpcServer::server_tcp(addr, server, rt)?;

        Ok(())
    }

    pub fn server_tcp<T: RootManager>(
        addr: SocketAddr,
        server: RootManagerServer<T>,
        rt: Runtime,
    ) -> anyhow::Result<()> {
        rt.block_on(async {
            //let addr = "[::1]:50051".parse()?;
            log::debug!("server_tcp: listen on {:?}", addr);
            let service = tonic_web::config()
                // .allow_origins(vec!["127.0.0.1"])
                .enable(server);

            let res = Server::builder()
                .accept_http1(true)
                .add_service(service)
                .serve(addr)
                .await
                .expect("server builder fail!");

            log::debug!("server_tcp: {:?}", res);
        });
        Ok(())
    }
}
