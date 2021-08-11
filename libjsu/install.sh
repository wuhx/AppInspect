set -e 

ln -s ../protos . || true

OUTPUT=target/aarch64-linux-android/release/liblibjsu.so
rm $OUTPUT || true

TARGET=../Riru-AppInspect/template/magisk_module/system/lib64/libjsu.so

cargo build --target aarch64-linux-android --release

cp $OUTPUT $TARGET

