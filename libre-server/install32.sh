set -e 

ln -s ../protos . || true

OUTPUT=target/armv7-linux-androideabi/release/liblibre_server.so

TARGET=../Riru-AppInspect/template/magisk_module/system/lib/libre_server.so

rm $OUTPUT || echo rm fail

cargo build --target aarch64-linux-android --release
ls -lh $OUTPUT
$ANDROID_NDK/toolchains/llvm/prebuilt/darwin-x86_64/aarch64-linux-android/bin/strip $OUTPUT

echo cp $OUTPUT $TARGET
echo cp $OUTPUT $TARGET