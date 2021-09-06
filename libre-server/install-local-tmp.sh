set -e 

ln -s ../protos . || true

#OUTPUT=target/aarch64-linux-android/release/liblibre_server.so
OUTPUT=target/aarch64-linux-android/debug/liblibre_server.so

TARGET=/data/local/tmp/libre_server.so

export BUILD_TIME=$(date)

rm $OUTPUT || echo rm fail

cargo build --target aarch64-linux-android

adb shell su -c setenforce 0
echo adb push $OUTPUT $TARGET
adb push $OUTPUT $TARGET
