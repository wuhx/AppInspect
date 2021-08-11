//package com.defyun.channel.impl;
//
//import android.content.Context;
//import android.content.Intent;
//import android.net.ConnectivityManager;
//
//import com.defyun.channel.AndroidProtocolManager;
//import com.defyun.pb.AppManagerProtocol;
//import com.cloudmonad.inspect.App;
////import com.cloudmonad.inspect.FwRequestDialog;
//
//import java.net.InetSocketAddress;
//import java.nio.ByteBuffer;
//
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.android.FlutterActivityLaunchConfigs;
//
//import static android.system.OsConstants.IPPROTO_TCP;
//
//public class FwRequest {
//    public static ByteBuffer handle(AppManagerProtocol.RequestApi api) {
//        AppManagerProtocol.FwRequestReq req = api.getFwRequestReq();
//
//        boolean res = startFwRequestDialog(req.getPkgName());
//        AppManagerProtocol.FwRequestResp resp = AppManagerProtocol.FwRequestResp
//                .newBuilder()
//                .setPkgName(req.getPkgName())
//                .setAllow(res)
//                .build();
//
//        return AndroidProtocolManager.toByteBuffer(resp);
//    }
//
//    public static void log(String msg) {
//        android.util.Log.d("FwRequest", msg);
//    }
//
//    public static boolean startFwRequestDialog(String app) {
////        log("API: startRequestActivity: " + app);
////        Context ctx = App.getContext();
////        log("startRequestActivity");
////        Intent intent = new Intent(ctx, FwRequestDialog.class);
////        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK|Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
////
////        intent.putExtra("app",app);
////
////        boolean result = true;
////        try {
////            ctx.startActivity(intent);
////        } catch(Exception e) {
////            log("startFwRequestDialog fail: " + e.getMessage());
////            result = false;
////        }
////        return  result;
//
//
//        Context ctx =App.getContext();
//
////        App.keepRoute();
////        App.flutterEngine.getNavigationChannel().setInitialRoute("/netreq");
//        //05-10 12:23:39.867  8057  8477 D AndroidProtocolManager: API: jniMethodCall fail: java.lang.RuntimeException: Methods marked with @UiThread must be executed on the main thread. Current thread: tun-thread
//
//        Intent intent = FlutterActivity.withCachedEngine("my_engine_id")
//                .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
//                .build(ctx);
////        intent.putExtra("app","com.tencent.mm");
//
////        log("Intent.FLAG_ACTIVITY_CLEAR_TASK");
//        intent.setFlags(
//            Intent.FLAG_ACTIVITY_NEW_TASK |
//            Intent.FLAG_ACTIVITY_CLEAR_TASK |
//            Intent.FLAG_ACTIVITY_NO_HISTORY|
//            Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS |
//            Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
//
//        boolean result = true;
//        try {
//            ctx.startActivity(intent);
//        } catch(Exception e) {
//            log("startFwRequestDialog fail: " + e.getMessage());
//            result = false;
//        }
//        return  result;
//    }
//
//
//
//}
