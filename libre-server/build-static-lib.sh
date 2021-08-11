set -e 

ln -s ../protos . || true

BUNDLE=bundle/arm64-v8a

#OUTPUT=target/aarch64-linux-android/debug/liblibre_server.a
OUTPUT=target/aarch64-linux-android/release/liblibre_server.a
OUTPUT32=target/armv7-linux-androideabi/release/liblibre_server.a

TARGET=../Riru-AppInspect/module/src/main/cpp/rlib/arm64-v8a
TARGET32=../Riru-AppInspect/module/src/main/cpp/rlib/armeabi-v7a
mkdir -p $TARGET || true
mkdir -p $TARGET32 || true

rm $OUTPUT || echo rm fail
#rm $OUTPUT32 || echo rm fail

cargo build --target aarch64-linux-android --release
#cargo build --target armv7-linux-androideabi --release

cp $OUTPUT $BUNDLE/libre_server.a

echo $TARGET 
TARGET_ABS=$(realpath $TARGET)
echo $TARGET_ABS
pushd bundle/arm64-v8a
./bundle.sh
echo cp libre_server_bundle.a $TARGET_ABS
cp libre_server_bundle.a $TARGET_ABS
popd



#cp $OUTPUT $TARGET
#cp $OUTPUT32 $TARGET32/libre_server.a 
