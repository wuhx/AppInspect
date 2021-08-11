use std::io;
use std::io::Cursor;
use std::io::Read;
use std::net::SocketAddr;
use std::path::Path;

#[test]
fn test_extract_site() {
    extract_site("out_dir");
}
fn extract_site(out_dir: &str) -> anyhow::Result<()> {
    log::debug!("init static site: {}", out_dir);
    let bytes = include_bytes!("../static-site.zip");
    let buf = Cursor::new(&bytes[..]);

    crate::unzip::extract(buf, out_dir)?;
    Ok(())
}

pub async fn run_server(port: u16) -> anyhow::Result<()> {
    let pkg_name = crate::get_pkg_name()?;
    let site_root = format!("/data/data/{}/site", pkg_name);
    if !Path::new(&site_root).exists() {
        extract_site(&site_root);
    }
    let addr: SocketAddr = format!("{}:{}", "0.0.0.0", port).parse()?;
    log::debug!(
        "start static server at {:?}, bind addr: {:?}",
        site_root,
        addr
    );
    // let site_root = format!("/data/local/tmp/site");

    warp::serve(warp::fs::dir(site_root)).run(addr).await;

    Ok(())
}
