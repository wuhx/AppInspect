use std::fs;
use std::fs::File;
use std::io::prelude::*;
use std::io::{self, Read, Seek};
use std::path::Path;
use walkdir::{DirEntry, WalkDir};
use zip::result::ZipError;
use zip::write::FileOptions;

fn zip_dir<T>(
    it: &mut dyn Iterator<Item = DirEntry>,
    prefix: &str,
    writer: T,
    method: zip::CompressionMethod,
) -> zip::result::ZipResult<()>
where
    T: Write + Seek,
{
    let mut zip = zip::ZipWriter::new(writer);
    let options = FileOptions::default()
        .compression_method(method)
        .unix_permissions(0o755);

    let mut buffer = Vec::new();
    for entry in it {
        let path = entry.path();
        let name = path.strip_prefix(Path::new(prefix)).unwrap();

        // Write file or directory explicitly
        // Some unzip tools unzip files with directory paths correctly, some do not!
        if path.is_file() {
            println!("adding file {:?} as {:?} ...", path, name);
            #[allow(deprecated)]
            zip.start_file_from_path(name, options)?;
            let mut f = File::open(path)?;

            f.read_to_end(&mut buffer)?;
            zip.write_all(&*buffer)?;
            buffer.clear();
        } else if name.as_os_str().len() != 0 {
            // Only if not root! Avoids path spec / warning
            // and mapname conversion failed error on unzip
            println!("adding dir {:?} as {:?} ...", path, name);
            #[allow(deprecated)]
            zip.add_directory_from_path(name, options)?;
        }
    }
    zip.finish()?;
    Result::Ok(())
}

pub fn zip(src_dir: &str, dst_file: &str) -> anyhow::Result<()> {
    let method = zip::CompressionMethod::Bzip2;
    if !Path::new(src_dir).is_dir() {
        anyhow::bail!("{} not exists!", src_dir);
    }

    let path = Path::new(dst_file);
    let file = File::create(&path).unwrap();

    let walkdir = WalkDir::new(src_dir.to_string());
    let it = walkdir.into_iter();

    zip_dir(&mut it.filter_map(|e| e.ok()), src_dir, file, method)?;

    Ok(())
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    //tonic_build::compile_protos("proto/greet.proto")?;
    let site = std::env::var("STATIC_SITE")?;
    zip(&site, "static-site.zip")?;
    tonic_build::compile_protos("../protos/app_manager.proto")?;
    Ok(())
}
