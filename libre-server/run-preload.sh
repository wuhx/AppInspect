set -e 

#APP=com.luojilab.player
#APP=com.example.apprs
#APP=com.tencent.mm
#APP=com.netease.newsreader.activity
APP=com.cloudmonad.artdemo


./build.sh

SO_ON_DEVICE_TMP=/data/local/tmp/libre_server.so
OUTPUT=libre_server.so

source ~/.profile.d/common/adb.env 
adb push $OUTPUT $SO_ON_DEVICE_TMP

adb shell am force-stop $APP

adb shell su -c setenforce 0
#adb shell su -c setprop wrap.$APP x
adb shell su -c setprop wrap.$APP LD_PRELOAD=$SO_ON_DEVICE_TMP
echo GET PROP $(adb shell getprop wrap.$APP)


adb shell monkey -p $APP  -c android.intent.category.LAUNCHER 1
#adb shell logcat -G 100M

logcat-rs $APP
