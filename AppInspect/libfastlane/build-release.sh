export STATIC_SITE=../build/web
rustup target add aarch64-linux-android
rustup target add armv7-linux-androideabi

ln -s ../protos . || true


OUTPUT=target/aarch64-linux-android/release/liblibfastlane.so
OUTPUT32=target/armv7-linux-androideabi/release/liblibfastlane.so
TARGET=../android/app/src/main/jniLibs/arm64-v8a/libfastlane.so
TARGET32=../android/app/src/main/jniLibs/armeabi-v7a/libfastlane.so
rm $OUTPUT
rm $TARGET
mkdir -p $(dirname $TARGET)
mkdir -p $(dirname $TARGET32)

#export RUSTFLAGS+=" --remap-path-prefix=/Users/wuhx/=homexx"
#export RUSTFLAGS="--remap-path-prefix=/Users/wuhx/.cargo/registry=registry"
#export RUSTFLAGS+=" --remap-path-prefix=/Users/wuhx/project.d/lwip-rs/src=lrsd"
#export RUSTFLAGS+=" --remap-path-prefix=/Users/wuhx/project.d/=prjd"
#export RUSTFLAGS+=" --remap-path-prefix=$PWD=./."
#export RUSTFLAGS+=" -C link-arg='-s'"
echo $RUSTFLAGS
cargo build --target aarch64-linux-android --release
cargo build --target armv7-linux-androideabi --release

ls -lh $OUTPUT
$ANDROID_NDK/toolchains/llvm/prebuilt/darwin-x86_64/aarch64-linux-android/bin/strip $OUTPUT
ls -lh $OUTPUT

cp $OUTPUT $TARGET
cp $OUTPUT32 $TARGET32
