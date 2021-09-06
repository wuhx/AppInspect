set -e

SCRIPT_DIR=$(dirname $(realpath "$0"))

export STATIC_SITE=../build/web

$SCRIPT_DIR/init.sh

cargo build --target aarch64-linux-android 
