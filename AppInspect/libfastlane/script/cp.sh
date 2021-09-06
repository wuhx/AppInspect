set -e

CUR_DIR=$(dirname $(realpath "$0"))


APP_ROOT=$(realpath $CUR_DIR/../..)
LIB_ROOT=$(realpath $CUR_DIR/..)
echo $PRJ_ROOT

OUTPUT=$LIB_ROOT/target/aarch64-linux-android/release/liblibfastlane.so
OUTPUT32=$LIB_ROOT/target/armv7-linux-androideabi/release/liblibfastlane.so
TARGET=$APP_ROOT/android/app/src/main/jniLibs/arm64-v8a/libfastlane.so
TARGET32=$APP_ROOT/android/app/src/main/jniLibs/armeabi-v7a/libfastlane.so

#rm $OUTPUT  || true
#rm $OUTPUT32 || true

#rm $TARGET || true
mkdir -p $(dirname $TARGET) || true
mkdir -p $(dirname $TARGET32) || true


echo cp $OUTPUT $TARGET
cp $OUTPUT $TARGET
echo cp $OUTPUT32 $TARGET32
cp $OUTPUT32 $TARGET32
