use std::error::Error;
use std::time::Duration;

use futures::stream;
use rand::rngs::ThreadRng;
use rand::Rng;
use tokio::time;
use tonic::transport::Channel;
use tonic::Request;

use libfastlane::app_manager_protocol as pb;
use libfastlane::app_manager_protocol::android_manager_client::AndroidManagerClient;
use libfastlane::app_manager_protocol::*;
use prost::Message;
use chrono::DateTime;


#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let target = "http://lo:10010";
    // let target = "http://192.168.0.103:10010";
    let mut client = AndroidManagerClient::connect(target).await?;

    // println!("\n*** SERVER STREAMING ***");
    // get_fw_ui(&mut client).await?;
    // fw_rule_get(&mut client).await?;
    // fw_rule_set(&mut client, "com.tencent.mm", true).await?;
    // fw_rule_set(&mut client, "com.duowan.kiwi", false).await?;
    // fw_rule_get(&mut client).await?;

    // get_app_bandwidth(&mut client).await?;
    // get_metric(&mut client).await?;

    Ok(())
}
