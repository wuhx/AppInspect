set -e 

ln -s ../protos . || true

OUTPUT=target/armv7-linux-androideabi/release/liblibjsu.so

rm $OUTPUT || true

TARGET=../Riru-AppInspect/template/magisk_module/system/lib/libjsu.so

cargo build --target armv7-linux-androideabi --release

cp $OUTPUT $TARGET

