//package com.defyun.channel.impl;
//
//import android.content.Context;
//import android.content.Intent;
//
//import com.defyun.pb.AppManagerProtocol;
//import com.cloudmonad.inspect.App;
//import com.defyun.vpn.VpnActivity;
//
//import java.nio.ByteBuffer;
//import java.util.ArrayList;
//import java.util.List;
//
//import static com.defyun.channel.AndroidProtocolManager.toByteBuffer;
//
//public class VpnManager {
//    static void log(String msg) {
//        android.util.Log.d("VpnManager", msg);
//    }
//    static boolean gVpnStarted = false;
//
//    public static ByteBuffer handle(AppManagerProtocol.RequestApi api) {
//        if (api.hasStartVpnReq()) {
//            AppManagerProtocol.StartVpnReq req = api.getStartVpnReq();
////            log("API: StartVpnReq " + req.getAppUseVpnList());
//            VpnManager.startVpn(req.getAppUseVpnList());
//        } else {
//            AppManagerProtocol.StopVpnReq req = api.getStopVpnReq();
//            log("API: Stop vpn ");
//            VpnManager.stopVpn();
//        }
//
//        AppManagerProtocol.VpnResp resp = AppManagerProtocol.VpnResp.newBuilder()
//                .setInfo("OK")
//                .setStatus(0)
//                .build();
//        return toByteBuffer(resp);
//    }
//
//    static void startVpn( List<String> appUseVpn) {
//
//        log("startVpn: " + gVpnStarted);
//        if(gVpnStarted) {
//            log("startVpn:  allready called return");
//            return;
//        }
//        gVpnStarted = true;
//        Context ctx = App.getContext();
//        Intent intent = new Intent(ctx, VpnActivity.class);
//        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//        intent.putExtra("isStop",false);
//        intent.putExtra("app_use_vpn", new ArrayList<String>(appUseVpn));
//        ctx.startActivity(intent);
//    }
//
//
//    static void stopVpn() {
//        Context ctx = App.getContext();
//        Intent intent = new Intent(ctx, VpnActivity.class);
//        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//        intent.putExtra("isStop",true);
//        ctx.startActivity(intent);
//    }
//
//}
