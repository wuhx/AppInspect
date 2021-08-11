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

pub fn extract_file(zip_file: &str, output_dir: &str) -> anyhow::Result<()> {
    let fname = std::path::Path::new(zip_file);
    let file = std::fs::File::open(&fname)?;
    extract(file, output_dir)?;
    Ok(())
}

pub fn extract<R: Read + io::Seek>(file: R, output_dir: &str) -> anyhow::Result<()> {
    let output_path = std::path::Path::new(output_dir);

    let mut archive = zip::ZipArchive::new(file)?;

    for i in 0..archive.len() {
        let mut file = archive.by_index(i)?;
        let outpath = match file.enclosed_name() {
            Some(path) => output_path.join(path.to_owned()),
            None => continue,
        };

        {
            let comment = file.comment();
            if !comment.is_empty() {
                // println!("File {} comment: {}", i, comment);
            }
        }

        if (&*file.name()).ends_with('/') {
            // println!("File {} extracted to \"{}\"", i, outpath.display());
            fs::create_dir_all(&outpath)?;
        } else {
            // println!(
            //     "File {} extracted to \"{}\" ({} bytes)",
            //     i,
            //     outpath.display(),
            //     file.size()
            // );
            if let Some(p) = outpath.parent() {
                if !p.exists() {
                    fs::create_dir_all(&p).unwrap();
                }
            }
            let mut outfile = fs::File::create(&outpath).unwrap();
            io::copy(&mut file, &mut outfile).unwrap();
        }

        // Get and Set permissions
        #[cfg(unix)]
        {
            use std::os::unix::fs::PermissionsExt;

            if let Some(mode) = file.unix_mode() {
                fs::set_permissions(&outpath, fs::Permissions::from_mode(mode)).unwrap();
            }
        }
    }
    Ok(())
}

#[test]
fn test_zip() {
    let src_dir = "site";
    let dst_zip = "site.zip";
    // let res = zip(src_dir, dst_zip);
    // log::debug!("zip res: {:?}", res);

    let res = extract_file(dst_zip, "site_ext");
    log::debug!("unzip res: {:?}", res);

    // std::fs::remove_file(dst_zip).unwrap();
    // let _ = doit(src_dir, dst_zip, zip::CompressionMethod::Bzip2);
    // panic!("compress use {:?} ", start.elapsed());
}
