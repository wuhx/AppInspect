./gradlew assembleDebug

TARGET=../Riru-AppInspect/template/magisk_module/Agentd.apk
echo cp ./app/build/outputs/apk/debug/app-debug.apk $TARGET
cp ./app/build/outputs/apk/debug/app-debug.apk $TARGET

