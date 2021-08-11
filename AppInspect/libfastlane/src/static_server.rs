use std::net::SocketAddr;

pub async fn run_server(port: u16) -> anyhow::Result<()> {
    let pkg_name = crate::get_pkg_name()?;
    let site_root = format!("/data/data/{}/site", pkg_name);
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
