set -e

#pushd ../libre-server
#./install.sh
#./install32.sh
#popd
pushd rustlib
./install.sh
popd

rm out -fr || echo rm fail
./gradlew  module:zipDebug



OUT=$(basename $(ls out/*.zip))
adb push out/$OUT /data/local/tmp
adb shell su -c magisk --install-module /data/local/tmp/$OUT

#adb reboot

#adb wait-for-device

#adb shell logcat|grep Riru

