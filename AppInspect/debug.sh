set -e
export GRPC_TOKEN="com.cloudmonad.inspect.debug"
./gen_proto.sh
pushd libfastlane/
./script/run.sh
popd

JAVA_VERSION=11


APK=./build/app/outputs/apk/debug/app-debug.apk
#BUNDLE=./build/app/outputs/bundle/debug/app-release.aab
PKG=com.cloudmonad.inspect
APP_ID=com.cloudmonad.inspect
#flutter run
#flutter run --release --no-sound-null-safety

#jarsigner -verify -verbose -certs $APK

rm $APK || true

echo flutter build apk --debug  --target-platform android-arm64 --dart-define GRPC_TOKEN=$GRPC_TOKEN
flutter build apk --debug  --target-platform android-arm64 --dart-define GRPC_TOKEN=$GRPC_TOKEN

ls -lh $APK
cp $APK DEBUG

#flutter build appbundle --obfuscate --split-debug-info=./bundle-symbols --target-platform android-arm64
#ls -lh $BUNDLE
#cp $BUNDLE RELEASE


adb uninstall $APP_ID || true

adb install -r $APK

adb shell am start -n $APP_ID/$PKG.MainActivity

./deploy.sh

logcat-rs $APP_ID
