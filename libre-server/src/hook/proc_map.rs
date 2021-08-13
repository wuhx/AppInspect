use libc;
use std;
use std::fs::File;
use std::io::Read;

pub type Pid = libc::pid_t;

#[derive(Debug, Clone, PartialEq)]
pub struct MapRange {
    pub range_start: usize,
    pub range_end: usize,
    pub offset: usize,
    pub dev: String,
    flags: String,
    inode: usize,
    pub pathname: Option<String>,
}

impl MapRange {
    /// Returns the size of this MapRange in bytes
    pub fn size(&self) -> usize {
        self.range_end - self.range_start
    }
    /// Returns the address this MapRange starts at
    pub fn start(&self) -> usize {
        self.range_start
    }
    /// Returns the filename of the loaded module
    pub fn filename(&self) -> &Option<String> {
        &self.pathname
    }
    /// Returns whether this range contains executable code
    pub fn is_exec(&self) -> bool {
        &self.flags[2..3] == "x"
    }
    /// Returns whether this range contains writeable memory
    pub fn is_write(&self) -> bool {
        &self.flags[1..2] == "w"
    }
    /// Returns whether this range contains readable memory
    pub fn is_read(&self) -> bool {
        &self.flags[0..1] == "r"
    }
}

/// Gets a Vec of [`MapRange`](linux_maps/struct.MapRange.html) structs for
/// the passed in PID. (Note that while this function is for linux, the OSX,
/// Windows, and FreeBSD variants have the same interface)
pub fn get_process_maps(pid: Pid) -> std::io::Result<Vec<MapRange>> {
    // Parses /proc/PID/maps into a Vec<MapRange>
    let maps_file = format!("/proc/{}/maps", pid);
    let mut file = File::open(maps_file)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    Ok(parse_proc_maps(&contents))
}
pub fn get_process_maps_self() -> std::io::Result<Vec<MapRange>> {
    // Parses /proc/PID/maps into a Vec<MapRange>
    let maps_file = format!("/proc/self/maps");
    let mut file = File::open(maps_file)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    Ok(parse_proc_maps(&contents))
}

fn parse_proc_maps(contents: &str) -> Vec<MapRange> {
    let mut vec: Vec<MapRange> = Vec::new();
    for line in contents.split("\n") {
        let mut split = line.split_whitespace();
        let range = split.next();
        if range == None {
            break;
        }
        let mut range_split = range.unwrap().split("-");
        let range_start = range_split.next().unwrap();
        let range_end = range_split.next().unwrap();
        let flags = split.next().unwrap();
        let offset = split.next().unwrap();
        let dev = split.next().unwrap();
        let inode = split.next().unwrap();

        vec.push(MapRange {
            range_start: usize::from_str_radix(range_start, 16).unwrap(),
            range_end: usize::from_str_radix(range_end, 16).unwrap(),
            offset: usize::from_str_radix(offset, 16).unwrap(),
            dev: dev.to_string(),
            flags: flags.to_string(),
            inode: usize::from_str_radix(inode, 10).unwrap(),
            pathname: Some(split.collect::<Vec<&str>>().join(" ")).filter(|x| !x.is_empty()),
        });
    }
    vec
}
