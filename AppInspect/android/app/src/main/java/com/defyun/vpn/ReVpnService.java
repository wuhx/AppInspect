package com.defyun.vpn;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.VpnService;
import android.os.IBinder;
import android.os.ParcelFileDescriptor;

import com.cloudmonad.inspect.App;

import java.util.ArrayList;
import java.util.List;

//https://android.googlesource.com/platform/development/+/master/samples/ToyVpn/src/com/example/android/toyvpn/ToyVpnService.java
public class ReVpnService extends VpnService {

    private static ReVpnService instance = null;


    public native int tunStart(int to);
    public native int tunStop();

    Thread th = null;
    public static void log(String msg) {
        android.util.Log.d("ReVpnService", msg);
    }



    @Override
    public void onCreate() {
        super.onCreate();
    }

    //    private final VpnService mService;

    public ReVpnService() {
//        this.mService = mService;
    }

    public ParcelFileDescriptor create_interface(List<String> app_use_vpn)  throws Exception {
        // Configure a new interface from our VpnService instance. This must be done
        // from inside a VpnService.
        VpnService.Builder builder = new VpnService.Builder();

        // Create a local TUN interface using predetermined addresses. In your app,
        // you typically use values returned from the VPN gateway during handshaking.


        for(String app : app_use_vpn) {
//            log("addAllowedApplication: xxxxxx ignore" + app);
//            builder.addAllowedApplication(app);
        }

//        log("addAllowedApplication com.duowan.kiwi");
//        builder.addAllowedApplication("com.duowan.kiwi");

        builder.addDisallowedApplication("com.cloudmonad.inspect");

        ParcelFileDescriptor localTunnel = builder
                .addAddress("10.24.0.2", 24)
                .addRoute("0.0.0.0", 0)
//                .addDnsServer("10.20.30.1")
                .establish();

        return localTunnel;
    }

//    @Override
//    public IBinder onBind(Intent intent) {
//        log("onBind");
//        // TODO: Return the communication channel to the service.
//
//        throw new UnsupportedOperationException("Not yet implemented");
//    }

//    boolean is_stop = false;
    void stop() {
//        is_stop = true;
        log("call tunStop, killProcess:" + android.os.Process.myPid());
//        tunStop();
//        android.os.Process.killProcess(android.os.Process.myPid());


//        stopForeground(true);

    }
    void start(List<String> app_use_vpn) {
//        log("ReVpnService start!");
        if(instance != null) {
            log("VpnService already start!");
            return;
        } else {
            instance = this;
        }
//        is_stop = false;
        try {
            ParcelFileDescriptor inf = create_interface(app_use_vpn);
            int fd = inf.detachFd();
            log(String.format("create_interface: %d",fd));

            th = new Thread(new Runnable() {
                @Override
                public void run() {

//                    try {
//                        Thread.sleep(5000);
//                        FwRequest.startFwRequestDialog("baidu.com thread: " );
//
//                    }catch (Exception e) {
//                       log("sleep fail: " + e.getMessage());
//                    }

//                    log("start in thread!");
                    int res = tunStart(fd);
//                    log("start in thread over");
                }
            });
            th.setName("tun-thread");
            th.start();
        } catch (Exception e) {
            log("start tun fail: " + e.getMessage());
        }

    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
//        System.loadLibrary("fw");
        String action = intent.getAction();
        log("onStartCommand: " + action);

        if (intent != null && "ACTION_STOP".equals(action)) {
            log("ACTION_STOP");
            stop();
            return START_NOT_STICKY;
        } else {
//            int port = intent.getExtras().getInt("port");
//            List<String> app_use_vpn = intent.getExtras().getStringArrayList("app_use_vpn");
//            log("getExtra app_use_vpn: " + app_use_vpn);
            List<String> app_use_vpn = new ArrayList<>();
            start(app_use_vpn);
            return START_STICKY;
        }

    }

//  vpnserver不能简单通过调用stopService停止
//    @Override
//    public void onDestroy() {
//        log("onDestroy");
//
//        //disconnect();
//    }


}