use libfastlane::android_manager_protocol::*;
use libfastlane::DbInterface;
use lwip_rs::l64a;
use rand::Rng;
use rusqlite::Connection;
use std::time::{Duration, Instant};

fn test_db_interface() {
    let test_db_name = "test_data.metrics";
    let conn = Connection::open(test_db_name).unwrap();
    let res = MetricsAppBandwidthResp::init(&conn);

    fn get_epoch_ms() -> u64 {
        std::time::SystemTime::now()
            .duration_since(std::time::UNIX_EPOCH)
            .unwrap()
            .as_millis() as u64
    }

    let th = std::thread::spawn(move || {
        let mut conn = Connection::open(test_db_name).unwrap();
        conn.execute_batch("pragma journal_mode=WAL").unwrap();

        loop {
            std::thread::sleep(Duration::from_millis(1000));
            let value = rand::thread_rng().gen::<f32>();
            let msg = MetricsAppBandwidthResp {
                pkg_name: "com.tencent.mm111".to_owned(),
                timestamp: get_epoch_ms(),
                value,
            };
            MetricsAppBandwidthResp::insert(&mut conn, vec![msg]);
        }
    });

    std::thread::sleep(Duration::from_millis(5000));
    let duration = Duration::from_millis(5000);
    let start = Instant::now() - duration;
    let res = MetricsAppBandwidthResp::query(&conn, start, duration).unwrap();
    for r in res {
        println!("res: {:?}", r.pkg_name);
    }

    th.join();
}

fn main() {
    log_rs::Log::init();
    test_db_interface();
}
