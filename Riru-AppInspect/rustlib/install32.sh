set -e
TARGET32=target/armv7-linux-androideabi/release/librustlib.a

rm $TARGET32 || true
cargo build --target armv7-linux-androideabi --release

cp $TARGET32 ../module/src/main/cpp/rlib/armeabi-v7a/librust.a
