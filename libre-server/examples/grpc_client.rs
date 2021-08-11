use std::error::Error;
use std::time::Duration;

use futures::stream;
use rand::rngs::ThreadRng;
use rand::Rng;
use tokio::time;
use tonic::transport::Channel;
use tonic::Request;

use chrono::DateTime;
use libre_server::android_manager_protocol as pb;
use libre_server::android_manager_protocol::android_manager_client::AndroidManagerClient;
use libre_server::android_manager_protocol::*;
use prost::Message;
use tonic::body::Body;
use tonic::codegen::{HttpBody, StdError};
use tonic::metadata::MetadataValue;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("main!");
    let target = "http://lo:10015";
    // let target = "http://192.168.0.103:10010";
    let mut client = AndroidManagerClient::connect(target).await?;
    let token = MetadataValue::from_str("Bearer com.example.apprs")?;
    let channel = Channel::from_static(target).connect().await?;

    let mut client = AndroidManagerClient::with_interceptor(channel, move |mut req: Request<()>| {
        req.metadata_mut().insert("authorization", token.clone());
        Ok(req)
    });
    println!("list_modules start");
    list_symbols(client).await?;
    println!("list_modules over");

    Ok(())
}

pub async fn list_symbols<T>(mut client: AndroidManagerClient<T>) -> anyhow::Result<()>
where
    T: tonic::client::GrpcService<tonic::body::BoxBody>,
    T::ResponseBody: Body + HttpBody + Send + 'static,
    T::Error: Into<StdError>,
    <T::ResponseBody as HttpBody>::Error: Into<StdError> + Send,
{
    let req = HookListSymbolsReq {
        module_name: "libart.so".to_string(),
    };

    let resp = client.hook_list_symbols(req).await?;
    println!("resp: {:?}", resp);
    Ok(())
}

pub async fn list_modules<T>(mut client: AndroidManagerClient<T>) -> anyhow::Result<()>
where
    T: tonic::client::GrpcService<tonic::body::BoxBody>,
    T::ResponseBody: Body + HttpBody + Send + 'static,
    T::Error: Into<StdError>,
    <T::ResponseBody as HttpBody>::Error: Into<StdError> + Send,
{
    println!("hello world: {:?}", client);
    let req = HookListModulesReq {
        pkg_name: "".to_string(),
    };

    let resp = client.hook_list_modules(req).await?;
    println!("resp: {:?}", resp);
    Ok(())
}
