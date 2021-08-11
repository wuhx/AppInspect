use libfastlane::GrpcServer;

fn main() {
    log_rs::Log::init();
    libfastlane::app_metrics_monitor_thread();
    GrpcServer::start_runtime("0.0.0.0:10010");
}
