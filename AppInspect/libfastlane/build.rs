fn main() -> Result<(), Box<dyn std::error::Error>> {
    //tonic_build::compile_protos("proto/greet.proto")?;
    tonic_build::compile_protos("../protos/app_manager.proto")?;
    Ok(())
}
