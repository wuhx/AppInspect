set -e
TARGET=target/aarch64-linux-android/release/librustlib.a
TARGET32=target/armv7-linux-androideabi/release/librustlib.a

rm $TARGET || true
rm $TARGET32 || true
cargo build --target aarch64-linux-android --release
cargo build --target armv7-linux-androideabi --release

cp $TARGET ../module/src/main/cpp/rlib/arm64-v8a/librust.a
cp $TARGET32 ../module/src/main/cpp/rlib/armeabi-v7a/librust.a
