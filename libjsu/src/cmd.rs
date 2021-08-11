use tokio::process::Command;


#[test]
fn test_run_cmd() {
    let rt = tokio::runtime::Builder::new_multi_thread()
        .enable_all()
        .build().unwrap();

    let cmd = "touch /sss/aaaa";

    rt.block_on(async {
        let res = run_cmd(cmd.to_owned()).await;
        println!("res: {:?}",res);
    });
}
//touch /data/data
pub async fn run_cmd(cmd: String) -> anyhow::Result<String> {
    let mut args: Vec<&str> = cmd.trim().split_whitespace().collect();
    let exe = args.first().unwrap();
    let mut cmd = Command::new(exe);
    let args = args.drain(1..);
    cmd.args(args);

    println!("cmd: {:?}",cmd);
    //
    // let mut cmd2 = Command::new("echo");
    // cmd2.arg("hello");
    // cmd2.arg("world");
    // println!("cmd2: {:?}",cmd2);

    let output = cmd.output().await?;
    println!("output st: {}",output.status.success());
    if output.status.success() {
        let res = String::from_utf8(output.stdout)?;
        Ok(res)
    } else {
        let res = String::from_utf8(output.stderr)?;
        Ok(res)
    }

}