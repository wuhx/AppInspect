package com.defyun.channel;

import java.nio.ByteBuffer;

public class UiChannel {
    static void log(String msg) {
        android.util.Log.d("PackageManager", msg);
    }

    static ByteBuffer jniMethodCall(ByteBuffer input) {
//        long start = System.currentTimeMillis();
        ByteBuffer result = AndroidProtocolManager.handle(input);
//        log("API: UiChannel jvm jniMethodCall use " + (System.currentTimeMillis() - start) + " ms");
        return result;

    }

}
