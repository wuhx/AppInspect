set -e
./gradlew assembleDebug
cp ./app/build/outputs/apk/debug/app-debug.apk Agentd.apk

adb push Agentd.apk /data/local/tmp/agentd

adb shell /data/local/tmp/agentd/run.sh

