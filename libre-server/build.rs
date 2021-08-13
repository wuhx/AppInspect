fn main() -> Result<(), Box<dyn std::error::Error>> {
    //tonic_build::compile_protos("proto/greet.proto")?;
    let out_dir = std::path::PathBuf::from(std::env::var("OUT_DIR").unwrap());

    tonic_build::configure()
        .file_descriptor_set_path(out_dir.join("descriptor.bin"))
        .compile(&["./protos/android_manager.proto"], &["./protos"])?;

    let out_dir = std::env::var("OUT_DIR")?;
    let gen_file = format!("{}/android_manager.rs", out_dir);
    std::fs::copy(gen_file, "src/grpc/android_manager.rs")?;

    // std::env::set_var(
    //     "BUILD_TIME",
    //     chrono::Local::now().format("%a %b %e %T %Y").to_string(),
    // );

    Ok(())
}
