set -e
APP=com.cloudmonad.artdemo
adb shell am force-stop $APP
./install-local-tmp.sh
adb shell monkey -p $APP -c android.intent.category.LAUNCHER 1

logcat-rs $APP
