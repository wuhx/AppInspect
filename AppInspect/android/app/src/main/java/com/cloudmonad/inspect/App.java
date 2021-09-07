package com.cloudmonad.inspect;
import android.app.Application;
import android.content.Context;
import android.content.Intent;

import io.flutter.FlutterInjector;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.FlutterEngineGroup;
import io.flutter.embedding.engine.dart.DartExecutor;

public class App extends Application {

    static FlutterEngineGroup engineGroup;
    public static FlutterEngine engineMain;
    public static FlutterEngine engineFloat;
    private static App sApplication;

    static void log(String msg) {
        android.util.Log.d("App", msg);
    }

    FlutterEngine createEngine(Context activity, String dartEntryName) {
        DartExecutor.DartEntrypoint dartEntrypoint =
                new DartExecutor.DartEntrypoint(
                        FlutterInjector.instance().flutterLoader().findAppBundlePath(),
                        dartEntryName
                );
        log("trace route: createEngine: "+dartEntrypoint.toString());
        return engineGroup.createAndRunEngine(activity, dartEntrypoint);
    }

    public static Application getApplication() {
        return sApplication;
    }

    public static Context getContext() {
        return getApplication().getApplicationContext();
    }

    native int start();



    Thread mThread;


    void startFloatService() {
        Intent intent = new Intent(this, FloatService.class);
        startService(intent);
    }


//    private static final Handler mHandler = new Handler();
//
//    public static final void runOnUiThread(Runnable runnable) {
//        if (Thread.currentThread() == Looper.getMainLooper().getThread()) {
//            runnable.run();
//        } else {
//            mHandler.post(runnable);
//        }
//    }

//    public static void keepRoute() {
//        log("keep Route");
//        runOnUiThread(new Runnable() {
//            @Override
//            public void run() {
//                log("keep Route: App.flutterEngine.getNavigationChannel().setInitialRoute");
//                NavigationChannel ch = App.flutterEngine.getNavigationChannel();
////                ch.popRoute();
//                ch.pushRoute("/netreq");
//            }
//        });
//    }


    @Override
    public void onCreate() {
        super.onCreate();

        engineGroup = new FlutterEngineGroup(this);
        engineFloat = createEngine(this,"floatMain");
//        sApplication = this;
//        log("loadLibrary fastlane");
        System.loadLibrary("fastlane");

        startFloatService();
        mThread = new Thread(new Runnable() {
            @Override
            public void run() {
//                log("run in thread");
                start();
            }
        });
        mThread.start();

        sApplication = this;
        // Instantiate a FlutterEngine.
//        flutterEngine = new FlutterEngine(this);

        //fixme
//        flutterEngine.getNavigationChannel().setInitialRoute("/netreq");

//        log("create flutterEngine");
        // Start executing Dart code to pre-warm the FlutterEngine.
//        flutterEngine.getDartExecutor().executeDartEntrypoint(
//                DartExecutor.DartEntrypoint.createDefault()
//        );

        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
                .getInstance()
                .put("my_engine_id", engineFloat);

//        engineMain = new FlutterEngine(this);
//
//        // Start executing Dart code to pre-warm the FlutterEngine.
//        engineMain.getDartExecutor().executeDartEntrypoint(
//                DartExecutor.DartEntrypoint.createDefault()
//        );
//
//        // Cache the FlutterEngine to be used by FlutterActivity.
//        FlutterEngineCache
//                .getInstance()
//                .put("my_engine_id", engineMain);
    }
}