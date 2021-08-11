//package com.cloudmonad.inspect;
//
//import android.content.Context;
//import android.graphics.Color;
//import android.graphics.drawable.ColorDrawable;
//import android.os.Bundle;
//
//import androidx.annotation.NonNull;
//
//import io.flutter.FlutterInjector;
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.embedding.engine.dart.DartExecutor;
//import io.flutter.plugin.common.MethodCall;
//import io.flutter.plugin.common.MethodChannel;
//
///**
// * This is an Activity that displays one instance of Flutter.
// *
// * EngineBindings is used to bridge communication between the Flutter instance and the DataModel.
// */
//public class FwRequestDialog extends FlutterActivity {
//
//    //    val channel: MethodChannel
//    FlutterEngine engine;
//    String requestForApp;
//    static void log(String msg) {
//        android.util.Log.d("RequestDialog",msg);
//    }
//
//    private static final String APP_CHANNEL = "net_request_pkg";
//
//    @Override
//    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//        log("configureFlutterEngine");
//
//        new MethodChannel(flutterEngine.getDartExecutor(), APP_CHANNEL).setMethodCallHandler(
//                new MethodChannel.MethodCallHandler() {
//                    @Override
//                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
//                        if (call.method.equals("getAppName")) {
//
//
//                            if (requestForApp != null) {
//                                result.success(requestForApp);
//                            } else {
//                                result.error("UNAVAILABLE", "getAppName  not available.", null);
//                            }
//                        } else {
//                            result.notImplemented();
//                        }
//                    }
//                }
//        );
//    }
//
//
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
//
//        requestForApp = getIntent().getStringExtra("app");
//        log("FwRequestDialog onCreate: requestForApp " + requestForApp);
//
//        DartExecutor.DartEntrypoint  dartEntrypoint =
//                new DartExecutor.DartEntrypoint(
//                        FlutterInjector.instance().flutterLoader().findAppBundlePath(), "main_dialog"
//                );
//        engine = App.engines.createAndRunEngine(this, dartEntrypoint);
//
//
//        super.onCreate(savedInstanceState);//必须放在后面
//    }
//
//    public FlutterEngine provideFlutterEngine(@NonNull Context context) {
//        return engine;
//    }
//
//
//
//
////        override fun onDestroy() {
////        super.onDestroy()
//////        engineBindings.detach()
////        }
////
//
//
//
//}
