set -e

CUR_DIR=$(dirname $(realpath "$0"))

$CUR_DIR/init.sh
$CUR_DIR/build.sh
$CUR_DIR/cp.sh


