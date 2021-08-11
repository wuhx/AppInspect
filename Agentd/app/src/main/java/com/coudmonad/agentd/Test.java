package com.coudmonad.agentd;

import android.app.ActivityThread;
import android.app.Application;
import android.content.pm.ApplicationInfo;
import android.util.Log;

import com.coudmonad.agentd.wrappers.InputManager;
import com.coudmonad.agentd.wrappers.PackageManager;
import com.coudmonad.agentd.wrappers.ServiceManager;

import java.io.File;
import java.util.List;

public class Test {

    static void log(String msg) {
        System.out.println(msg);
    }

    public static final String TAG = "Agentd-Test";
    public static Thread mThread;

    static void sleep(int millseconds) {
        try {
            Thread.sleep(millseconds);
        } catch(Exception e) {
            Log.d(TAG, "sleep fail ");
        }
    }
    public static void load_so(String so_path) {
        Log.d(TAG, "Agentd start loaded: " + so_path);

        mThread = new Thread(new Runnable() {
            @Override
            public void run() {
                boolean nodelay = new File(so_path).exists();

                while(!nodelay) {
                    sleep(1000);
                    boolean filesMounted = new File(so_path).exists();
                    Log.d(TAG, "Agentd Thread: filesMounted: " + filesMounted);
                    if (filesMounted) {
                        sleep(3000);
                        break;
                    }
                }

//                System.loadLibrary("re_server");
//                System.load("/data/local/tmp/libre_server.so");
                System.load("/data/local/tmp/libjsu.so");
                Log.d(TAG, "Agentd start loaded!: " + so_path);
//                System.load(so_path);

            }
        });
        mThread.start();


    }


    public static void main(String[] args) {
        log("hello test");

//        load_so("/data/local/tmp/libre_server.so");
        load_so("/data/local/tmp/libjsu.so");
//        UdsServer uds = new UdsServer();
//        uds.start();

        while(true) {
            sleep(1000);
        }


//        ServiceManager mgr = new ServiceManager();
//        mgr.getInputManager();


//        Application application = ActivityThread.currentActivityThread().getApplication();

//        PackageManager pm = mgr.getpackageManager();
//        List<ApplicationInfo> res = pm.getInstalledApplications(0,0);
//        ApplicationInfo info = res.get(0);
//        log("res: " + res.size());
//        pm.getApplicationIcon(res.get(0));
//        pm.listFun();
//        for(ApplicationInfo app  : res) {
//            log("app: " + app.packageName);
//        }
//        List<ApplicationInfo> apps =  pm.getPersistentApplications(0);
//        log("apps: " + apps.size());

    }
}
