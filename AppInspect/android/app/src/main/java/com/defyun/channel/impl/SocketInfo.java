//package com.defyun.channel.impl;
//
//import android.content.Context;
//import android.net.ConnectivityManager;
//
//import com.defyun.channel.AndroidProtocolManager;
//import com.defyun.pb.AppManagerProtocol;
//import com.cloudmonad.inspect.App;
//import com.google.protobuf.GeneratedMessageLite;
//
//import java.net.InetSocketAddress;
//import java.nio.ByteBuffer;
//
//import static android.system.OsConstants.IPPROTO_TCP;
//
//public class SocketInfo {
//
//    static void log(String msg) {
//        android.util.Log.d("SocketInfo", msg);
//    }
//
//    public static ByteBuffer handle(AppManagerProtocol.RequestApi api) {
//        AppManagerProtocol.SocketInfoReq req = api.getSocketInfoReq();
//        AppManagerProtocol.SocketInfoResp resp = SocketInfo.getSocketInfo(req);
//        return AndroidProtocolManager.toByteBuffer(resp);
//    }
//
//    public static AppManagerProtocol.SocketInfoResp getSocketInfo(AppManagerProtocol.SocketInfoReq req) {
//        Context ctx = App.getContext();
//        ConnectivityManager cm =
//                (ConnectivityManager)ctx.getSystemService(Context.CONNECTIVITY_SERVICE);
//
//        InetSocketAddress local = new InetSocketAddress(req.getSrcIp(), req.getSrcPort());
//        InetSocketAddress remote= new InetSocketAddress(req.getDstIp(), req.getDstPort());
//
//        log("Api: getSocketInfo: " + remote.toString());
//
////        String pkg = "null";
////        int uid = 0;
//
//        int uid;
//        try {
//            uid = cm.getConnectionOwnerUid(IPPROTO_TCP,local,remote);
//            log("Api: getSocketInfo: uid = " + uid);
//        } catch(Exception e) {
//            log("fail to getConnectionOwnerUid:  " + e.getMessage());
//            uid = 0;
//        }
//        String[]  pkgs = ctx.getPackageManager().getPackagesForUid(uid);
//        String pkg;
//        if (pkgs == null) {
//            pkg = "null";
//        } else {
//            pkg = pkgs[0];
//        }
//
//        AppManagerProtocol.SocketInfoResp resp = AppManagerProtocol.SocketInfoResp.newBuilder()
//                .setPkgName(pkg)
//                .setUid(uid)
//                .build();
//        return resp;
//    }
//
//}
