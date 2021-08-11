// use tokio::net::UnixListener;
// use tokio::io::Interest;
// use tokio::net::UnixStream;
// use std::error::Error;
// use std::io;
//
//
// pub fn start() {
//     let rt = tokio::runtime::Builder::new_multi_thread()
//         .enable_all()
//         .build()
//         .unwrap();
//     rt.block_on(async {
//         // run_client().await;
//         run_server().await;
//     });
// }
// async fn run_server() {
//     let path = "/data/local/tmp/socket";
//     let mut listener = UnixListener::bind(path).unwrap();
//     println!("UDS bind: : {}",path);
//     loop {
//         match listener.accept().await {
//             Ok((stream, _addr)) => {
//                 println!("new client!");
//             }
//             Err(e) => { /* connection failed */ }
//         }
//     }
// }
//
// async fn run_client() {
//     let path = "/data/local/tmp/socket";
//     let stream = UnixStream::connect(path).await.unwrap();
//
//     println!("UDS stream: : {:?}",stream);
//     loop {
//         let ready = stream.ready(Interest::READABLE | Interest::WRITABLE).await.unwrap();
//
//         if ready.is_readable() {
//             let mut data = vec![0; 1024];
//             // Try to read data, this may still fail with `WouldBlock`
//             // if the readiness event is a false positive.
//             match stream.try_read(&mut data) {
//                 Ok(n) => {
//                     println!("read {} bytes", n);
//                 }
//                 Err(ref e) if e.kind() == io::ErrorKind::WouldBlock => {
//                     continue;
//                 }
//                 Err(e) => {
//                     println!("err: {:?}",e);
//                     break;
//                 }
//             }
//
//         }
//
//         if ready.is_writable() {
//             // Try to write data, this may still fail with `WouldBlock`
//             // if the readiness event is a false positive.
//             match stream.try_write(b"hello world") {
//                 Ok(n) => {
//                     println!("write {} bytes", n);
//                 }
//                 Err(ref e) if e.kind() == io::ErrorKind::WouldBlock => {
//                     continue;
//                 }
//                 Err(e) => {
//                     println!("err: {:?}",e);
//                     break;
//                 }
//             }
//         }
//     }
//
// }