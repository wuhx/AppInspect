package com.coudmonad.agentd;
import android.util.Log;

import java.io.File;

public class Main {

    static void log(String msg) {
//        System.out.println(msg);
        Log.d(TAG, msg);
    }

    public static final String TAG = "AppInspect-Agentd";

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


    public static Thread mThread;
    public static void main(String[] args) {
        log("hello test");

        load_so("/data/local/tmp/libjsu.so");
//        UdsServer uds = new UdsServer();
//        uds.start();

        while(true) {
            sleep(1000);
        }


//        Log.d(TAG, "Agentd start load!");
//        boolean filesMounted = new File("/system/lib64/libre_server.so").exists();
////        System.loadLibrary("re_server");
//        Log.d(TAG, "Agentd start end! filesMounted: " + filesMounted);
//
//        mThread = new Thread(new Runnable() {
//            @Override
//            public void run() {
//                while(true) {
//                    try {
//                        Thread.sleep(1000);
//                    } catch(Exception e) {
//                        Log.d(TAG, "sleep fail ");
//                    }
//                    boolean filesMounted = new File("/system/lib64/libre_server.so").exists();
//                    Log.d(TAG, "Agentd Thread: filesMounted: " + filesMounted);
//                    if (filesMounted) {
//                        break;
//                    }
//                }
//
////                System.loadLibrary("re_server");
//                System.load("/data/local/tmp/libjsu.so");
//
//                Log.d(TAG, "Agentd start loaded!");
//
//            }
//        });
//        mThread.start();


    }


}
