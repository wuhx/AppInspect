# AppInspect

### Download

[app-inspect-v0.0.1.zip](https://github.com/wuhx/AppInspect/blob/main/RELEASE/app-inspect-v0.0.1.zip?raw=true)

[AppInspect-0.0.1.apk](https://github.com/wuhx/AppInspect/blob/main/RELEASE/AppInspect-0.0.1.apk?raw=true)

### Install: 

1. install Riru module 
```sh
adb push app-inspect-v0.0.1.zip  /data/local/tmp
adb shell su -c magisk --install-module /data/local/tmp/app-inspect-v0.0.1.zip
adb reboot
```

2. install AppInspect App
```sh
adb install AppInspect-0.0.1.apk  
adb shell am start -n com.cloudmonad.inspect/.MainActivity
```




### More Info

[[原创]AppInspect : 一个纯手机端实现的无代码的hook框架](https://bbs.pediy.com/thread-269004-1.htm)

[从Frida源码学习ArtHook](https://github.com/wuhx/AppInspect/wiki)

