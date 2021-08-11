set -e 

ln -s ../protos . || true

#BUNDLE=bundle/arm64-v8a
BUNDLE=bundle/armeabi-v7a

OUTPUT=target/armv7-linux-androideabi/release/liblibre_server.a
TARGET=../Riru-AppInspect/module/src/main/cpp/rlib/armeabi-v7a
mkdir -p $TARGET || true

rm $OUTPUT || echo rm fail

cargo build --target armv7-linux-androideabi --release

cp $OUTPUT $BUNDLE/libre_server.a

TARGET_ABS=$(realpath $TARGET)
echo TARGET_ABS: $TARGET_ABS
pushd $BUNDLE
./bundle.sh
echo cp libre_server_bundle.a $TARGET_ABS
cp libre_server_bundle.a $TARGET_ABS
popd

