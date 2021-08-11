TARGET=/data/data/com.cloudmonad.inspect.debug/site
flutter build web
adb push build/web /data/local/tmp/site

adb shell su -c rm -fr $TARGET
adb shell su -c mkdir $TARGET
adb shell su -c mv /data/local/tmp/site/web/* $TARGET 
