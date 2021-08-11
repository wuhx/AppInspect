rustup target add aarch64-linux-android

OUTPUT=./target/aarch64-linux-android/debug/liblibfastlane.so
TARGET=../android/app/src/main/jniLibs/arm64-v8a/libfastlane.so
rm $OUTPUT
rm $TARGET
mkdir -p $(dirname $TARGET)

cargo build --target aarch64-linux-android

cp $OUTPUT $TARGET
#cp $OUTPUT ./libtask.so
