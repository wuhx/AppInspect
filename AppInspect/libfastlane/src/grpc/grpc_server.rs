// use super::UnixStream;
use crate::app_manager_protocol::app_manager_server::AppManagerServer;
use crate::get_pkg_name;
use once_cell::sync::Lazy;
use std::net::SocketAddr;
use std::ops::Deref;
use tonic::transport::Server;
use tonic::{metadata::MetadataValue, Request, Status};

static TOKEN: Lazy<String> = Lazy::new(|| {
    let tk = get_pkg_name().expect("Fail to Unify");
    tk
});

#[derive(Debug)]
pub struct GrpcServer {}

impl GrpcServer {
    pub fn new(bind_addr: &'static str) -> GrpcServer {
        log::debug!("GrpcServer: bind_addr:{}", bind_addr);

        GrpcServer {}
    }
    pub fn start_runtime(bind_addr: &str) -> anyhow::Result<()> {
        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()?;

        fn check_auth(req: Request<()>) -> Result<Request<()>, Status> {
            // let token: &'static str = env!("GRPC_TOKEN");
            let token = TOKEN.deref();

            log::debug!("token from GRPC_TOKEN: {}", token);

            let token = format!("Bearer {}", token);

            let token = MetadataValue::from_str(token.as_str()).unwrap();

            match req.metadata().get("authorization") {
                Some(token_recv) => {
                    if token == token_recv {
                        Ok(req)
                    } else {
                        log::error!("Auth fail: {:?} != {:?}", token_recv, token);
                        Err(Status::unauthenticated("No valid auth token"))
                    }
                }
                None => Err(Status::unauthenticated("No auth token")),
            }
        }

        let android_manager_impl = super::grpc_service::AppManagerImpl::default();
        let server = AppManagerServer::with_interceptor(android_manager_impl, check_auth);

        rt.block_on(async {
            //let addr = "[::1]:50051".parse()?;
            let addr: SocketAddr = bind_addr.parse().expect("fail to parse addr");
            log::debug!("server_tcp: listen on {:?}", addr);
            // let _res = Server::builder().add_service(server).serve(addr).await;
            let service = tonic_web::config()
                // .allow_origins(vec!["127.0.0.1"])
                .enable(server);

            let _res = Server::builder()
                .accept_http1(true)
                .add_service(service)
                .serve(addr)
                .await
                .expect("server builder fail!");
        });

        // if bind_addr.contains(":") {
        //     let addr: SocketAddr = bind_addr.parse()?;
        //     GrpcServer::server_tcp(addr, server, rt)?;
        // } else {
        //     GrpcServer::server_uds(bind_addr, server, rt)?;
        // }

        Ok(())
    }

    // pub fn server_uds<T: AppManager>(
    //     path: &str,
    //     server: AppManagerServer<T>,
    //     rt: Runtime,
    // ) -> anyhow::Result<()> {
    //     let incoming = {
    //         let uds = UnixListener::bind(path)?;
    //
    //         async_stream::stream! {
    //             while let item = uds.accept().map_ok(|(st, _)| UnixStream(st)).await {
    //                 yield item;
    //             }
    //         }
    //     };
    //
    //     rt.block_on(async {
    //         //let addr = "[::1]:50051".parse()?;
    //         log::debug!("server_uds: listen on {:?}", path);
    //         if let Err(err) = Server::builder()
    //             .add_service(server)
    //             .serve_with_incoming(incoming)
    //             .await
    //         {
    //             log::error!("serve_with_incoming fail: {:?}", err);
    //         }
    //     });
    //     Ok(())
    // }

    // pub fn server_tcp<T: AppManager>(
    //     addr: SocketAddr,
    //     server: AppManagerServer<T>,
    //     rt: Runtime,
    // ) -> anyhow::Result<()> {
    //     rt.block_on(async {
    //         //let addr = "[::1]:50051".parse()?;
    //         log::debug!("server_tcp: listen on {:?}", addr);
    //         // let _res = Server::builder().add_service(server).serve(addr).await;
    //         let service = tonic_web::config()
    //             // .allow_origins(vec!["127.0.0.1"])
    //             .enable(server);
    //
    //         let _res = Server::builder()
    //             .accept_http1(true)
    //             .add_service(service)
    //             .serve(addr)
    //             .await
    //             .expect("server builder fail!");
    //     });
    //     Ok(())
    // }
}
