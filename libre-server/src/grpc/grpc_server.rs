use crate::android_manager_protocol::android_manager_server::{
    AndroidManager, AndroidManagerServer,
};
use crate::get_pkg_name;
use crate::grpc_client::shutdown_old;
use futures_util::FutureExt;
use once_cell::sync::{Lazy, OnceCell};
use std::net::SocketAddr;
use std::ops::Deref;
// use std::sync::Mutex;
use tokio::runtime::Runtime;
use tokio::sync::oneshot::Sender;
use tonic::{metadata::MetadataValue, transport::Server};
use tonic::{Request, Status};

#[allow(dead_code)]
// fn retk() {}
static TOKEN: Lazy<String> = Lazy::new(|| {
    let tk = get_pkg_name().expect("Fail to Unify");

    tk
});
pub static mut G_STOP_SENDER: OnceCell<Box<Sender<()>>> = OnceCell::new();

#[derive(Debug)]
pub struct GrpcServer {
    // thread: std::thread::JoinHandle<()>,
    stop_tx: Sender<()>,
}
impl GrpcServer {
    pub fn start_runtime(bind_addr: &str) -> anyhow::Result<()> {
        let rt = tokio::runtime::Builder::new_current_thread()
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

        let android_manager_impl = super::grpc_service::AndroidManagerImpl::default();
        // let server = AndroidManagerServer::with_interceptor(android_manager_impl, check_auth);
        let server = AndroidManagerServer::new(android_manager_impl);
        let addr: SocketAddr = bind_addr.parse()?;

        GrpcServer::server_tcp(addr, server, rt)?;

        Ok(())
    }

    pub fn server_tcp<T: AndroidManager>(
        addr: SocketAddr,
        server: AndroidManagerServer<T>,
        rt: Runtime,
    ) -> anyhow::Result<()> {
        rt.block_on(async {
            //let addr = "[::1]:50051".parse()?;
            log::debug!("server_tcp: listen on {:?}", addr);

            let res = shutdown_old(&addr).await;
            log::debug!("shutdown_old: {:?}", res);

            let service = tonic_web::config()
                // .allow_origins(vec!["127.0.0.1"])
                .enable(server);

            let (tx, rx) = tokio::sync::oneshot::channel::<()>();
            unsafe {
                let _ = G_STOP_SENDER.set(Box::new(tx));
            }

            if let Err(err) = Server::builder()
                .accept_http1(true)
                .add_service(service)
                // .serve(addr)
                .serve_with_shutdown(addr, rx.map(drop))
                .await
            {
                log::error!("fail to build grpc server: {:?}", err);
            }
        });
        Ok(())
    }
}
