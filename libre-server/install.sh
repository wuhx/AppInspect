set -e 

ln -s ../protos . || true

OUTPUT=target/aarch64-linux-android/release/liblibre_server.so

TARGET=../Riru-AppInspect/template/magisk_module/system/lib64/libre_server.so

export BUILD_TIME=$(date)

rm $OUTPUT || echo rm fail

cargo build --target aarch64-linux-android --release

echo cp $OUTPUT $TARGET
cp $OUTPUT $TARGET