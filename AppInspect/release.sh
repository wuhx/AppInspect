set -e

[ -z "$1" ] && echo useage: ./release 1.0.2 &&  exit 1

export GRPC_TOKEN="com.cloudmonad.inspect"

flutter build web

./gen_proto.sh
pushd libfastlane/
./build-release.sh
popd

VER=$1
RELEASE_AAB=RELEASE/AppInspect-$VER.aab
RELEASE_APK=RELEASE/AppInspect-$VER.apk
echo release ver: $VER, RELEASE_AAB:$RELEASE_AAB RELEASE_APK:$RELEASE_APK


APK=./build/app/outputs/apk/release/app-release.apk
BUNDLE=./build/app/outputs/bundle/release/app-release.aab
PKG=com.cloudmonad.inspect
#flutter run
#flutter run --release --no-sound-null-safety

#jarsigner -verify -verbose -certs $APK

rm $APK || true

flutter build apk --obfuscate --split-debug-info=./symbols --target-platform android-arm64,android-arm
#flutter build apk --obfuscate --split-debug-info=./symbols --target-platform android-arm64
ls -lh $APK
#cp $APK RELEASE 

#flutter build appbundle --obfuscate --split-debug-info=./bundle-symbols --target-platform android-arm64,android-arm
#flutter build appbundle --obfuscate --split-debug-info=./bundle-symbols --target-platform android-arm64
#ls -lh $BUNDLE
#cp $BUNDLE RELEASE/

#cp $BUNDLE $RELEASE_AAB
cp $APK $RELEASE_APK


adb uninstall $PKG || true

adb install -r $APK

adb shell am start -n $PKG/.MainActivity

logcat-rs com.cloudmonad.inspect
