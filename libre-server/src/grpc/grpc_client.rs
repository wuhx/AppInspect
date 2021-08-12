use crate::android_manager_protocol::android_manager_client::AndroidManagerClient;
use crate::android_manager_protocol::HookServerExitReq;
use crate::get_pkg_name;
use std::net::SocketAddr;
// use tonic::codegen::{Body, StdError};
// use tonic::metadata::MetadataValue;
// use tonic::transport::Channel;
// use tonic::Request;
// use warp::hyper::body::HttpBody;
//
// pub struct GrpcClient<T> {
//     client: AndroidManagerClient<T>,
// }
// impl<T> GrpcClient<T>
// where
//     T: tonic::client::GrpcService<tonic::body::BoxBody>,
//     T::ResponseBody: Body + HttpBody + Send + 'static,
//     T::Error: Into<StdError>,
//     <T::ResponseBody as HttpBody>::Error: Into<StdError> + Send,
// {
//     pub async fn new(target: &str, token: &str) -> anyhow::Result<Self> {
//         // let target = "http://lo:10015";
//         // let target = "http://192.168.0.103:10010";
//         // let mut client = AndroidManagerClient::connect(target).await?;
//         let token = MetadataValue::from_str(format!("Bearer {}", token).as_str())?;
//         let channel = Channel::from_static(target).connect().await?;
//
//         let mut client =
//             AndroidManagerClient::with_interceptor(channel, move |mut req: Request<()>| {
//                 req.metadata_mut().insert("authorization", token.clone());
//                 Ok(req)
//             });
//
//         Ok(Self { client })
//     }
// }
//
// // async fn clist() -> anyhow::Result<()> {
// //     let target = "http://lo:10015";
// //     // let target = "http://192.168.0.103:10010";
// //     // let mut client = AndroidManagerClient::connect(target).await?;
// //     let token = MetadataValue::from_str("Bearer com.example.apprs")?;
// //     let channel = Channel::from_static(target).connect().await?;
// //
// //     let mut client = AndroidManagerClient::with_interceptor(channel, move |mut req: Request<()>| {
// //         req.metadata_mut().insert("authorization", token.clone());
// //         Ok(req)
// //     });
// //     println!("list_modules start");
// //     list_symbols(client).await?;
// //     println!("list_modules over");
// //
// //     Ok(())
// // }
//
// // pub async fn list_symbols<T>(mut client: AndroidManagerClient<T>) -> anyhow::Result<()>
// // where
// //     T: tonic::client::GrpcService<tonic::body::BoxBody>,
// //     T::ResponseBody: Body + HttpBody + Send + 'static,
// //     T::Error: Into<StdError>,
// //     <T::ResponseBody as HttpBody>::Error: Into<StdError> + Send,
// // {
// //     let req = HookListSymbolsReq {
// //         module_name: "libart.so".to_string(),
// //     };
// //
// //     let resp = client.hook_list_symbols(req).await?;
// //     println!("resp: {:?}", resp);
// //     Ok(())
// // }
// //
// // pub async fn list_modules<T>(mut client: AndroidManagerClient<T>) -> anyhow::Result<()>
// // where
// //     T: tonic::client::GrpcService<tonic::body::BoxBody>,
// //     T::ResponseBody: Body + HttpBody + Send + 'static,
// //     T::Error: Into<StdError>,
// //     <T::ResponseBody as HttpBody>::Error: Into<StdError> + Send,
// // {
// //     println!("hello world: {:?}", client);
// //     let req = HookListModulesReq {
// //         pkg_name: "".to_string(),
// //     };
// //
// //     let resp = client.hook_list_modules(req).await?;
// //     println!("resp: {:?}", resp);
// //     Ok(())
// // }

pub async fn shutdown_old(addr: &SocketAddr) -> anyhow::Result<bool> {
    if !is_port_available(addr.port()) {
        log::info!("ReServer in other App is running!");
        let pkg_name = get_pkg_name().unwrap_or("unknown".to_owned());
        let endpoint = format!("http://127.0.0.1:{}", addr.port());
        send(endpoint, pkg_name).await?;

        Ok(true)
    } else {
        Ok(false)
    }
}

pub fn is_port_available(port: u16) -> bool {
    match std::net::TcpListener::bind(("127.0.0.1", port)) {
        Ok(_) => true,
        Err(_) => false,
    }
}

async fn send(endpoint: String, new_pkg_name: String) -> anyhow::Result<()> {
    // let mut client = GreeterClient::connect("http://[::1]:50051").await?;
    let mut client = AndroidManagerClient::connect(endpoint.clone()).await?;

    let request = tonic::Request::new(HookServerExitReq { new_pkg_name });

    if let Err(err) = client.hook_server_exit(request).await {
        log::error!("Shutdown previous instance fail, Err {:?}", err);
    }

    Ok(())
}
