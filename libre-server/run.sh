set -e 

#APP=com.luojilab.player
APP=com.example.apprs
#APP=com.tencent.mm

ln -s ../protos . || true

OUTPUT=target/aarch64-linux-android/release/liblibre_server.so

rm $OUTPUT || echo rm fail
#rm $TARGET || echo rm fail
#mkdir -p $(dirname $TARGET)

SO_ON_DEVICE_TMP=/data/local/tmp/libre_server.so
#SO_ON_DEVICE_TMP=/data/adb/modules/hosts/system/lib64/libre_server.so

cargo build --target aarch64-linux-android --release
ls -lh $OUTPUT
$ANDROID_NDK/toolchains/llvm/prebuilt/darwin-x86_64/aarch64-linux-android/bin/strip $OUTPUT
#adb push $OUTPUT $SO_ON_DEVICE_TMP
source ~/.profile.d/common/adb.env 
adb_push $OUTPUT $SO_ON_DEVICE_TMP


#patchelf --set-soname libre_server.so $OUTPUT


adb shell am force-stop $APP 

adb logcat -c
sleep 2

adb shell monkey -p $APP  -c android.intent.category.LAUNCHER 1
#adb shell su -c "setenforce 0"
adb shell logcat -G 100M
#logcat-rs com.example.apprs

logcat-rs  -c com.example.apprs|grep -v "Accessing hidden"
