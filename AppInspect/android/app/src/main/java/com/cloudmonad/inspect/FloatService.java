package com.cloudmonad.inspect;

import android.annotation.SuppressLint;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.graphics.PixelFormat;
import android.os.IBinder;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;

import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterActivityLaunchConfigs;

public class FloatService extends Service implements View.OnTouchListener , View.OnClickListener {

    private WindowManager wm;
    private ImageView windowView;

    private float offsetX;
    private float offsetY;
    private int originalXPos;
    private int originalYPos;
    private boolean moving;
    private float lastX;
    private float lastY;


    public static void log(String msg) {
        android.util.Log.d("FloatService", msg);
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        log("onStartCommand5");
        floatWindow(400,500);

        // If we get killed, after returning from here, restart
        return START_STICKY;
    }

    void floatWindow(int x, int y) {
        log("floatWindow");

        if(wm == null) {
            wm = (WindowManager) getSystemService(WINDOW_SERVICE);
            log("getSystemService: {}" + wm);
        }

        windowView = new ImageView(this);
        log("chatHead: {}" + windowView);

        windowView.setImageResource(R.drawable.facetime);
        windowView.setOnTouchListener(this);
        windowView.setOnClickListener(this);


        if(windowView == null) {
            return;
        }

        WindowManager.LayoutParams params = new WindowManager.LayoutParams(
                WindowManager.LayoutParams.WRAP_CONTENT,
                WindowManager.LayoutParams.WRAP_CONTENT,
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
                PixelFormat.TRANSLUCENT);
        params.height = 100;
        params.width= 100;

        if(params== null) {
            return;
        }

        params.gravity = Gravity.TOP | Gravity.LEFT;
        params.x = x;
        params.y = y ;

        wm.addView(windowView, params);
    }

    @SuppressLint("ClickableViewAccessibility")
    @Override
    public boolean onTouch(View v, MotionEvent event) {
        if (null != wm) {
            if (event.getAction() == MotionEvent.ACTION_DOWN) {
                float x = event.getRawX();
                float y = event.getRawY();
                moving = false;
                int[] location = new int[2];
                windowView.getLocationOnScreen(location);
                originalXPos = location[0];
                originalYPos = location[1];
                offsetX = originalXPos - x;
                offsetY = originalYPos - y;
            } else if (event.getAction() == MotionEvent.ACTION_MOVE) {
                float x = event.getRawX();
                float y = event.getRawY();
                WindowManager.LayoutParams params = (WindowManager.LayoutParams) windowView.getLayoutParams();
                int newX = (int) (offsetX + x);
                int newY = (int) (offsetY + y);
                if (Math.abs(newX - originalXPos) < 1 && Math.abs(newY - originalYPos) < 1 && !moving) {
                    return false;
                }
                params.x = newX;
                params.y = newY;
                wm.updateViewLayout(windowView, params);
                moving = true;
            } else if (event.getAction() == MotionEvent.ACTION_UP) {
                return moving;
            }
        }
        return false;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (windowView != null) wm.removeView(windowView);
    }

    @Override
    public void onClick(View view) {
        int[] location = new int[2];
        windowView.getLocationOnScreen(location);
        log("click me! x:" + location[0] + " y:" + location[1]);
        startFloatActivity(this);
//        startFwRequestDialog("com.tencent.mm");

    }

    public void startFloatActivity(Context context) {
//        Intent intent = FlutterActivity
//                .withCachedEngine("my_engine_id")
//                .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
//                .build(context);

        Intent intent = new Intent(context, FloatActivity.class);
//        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        intent.setFlags(
                Intent.FLAG_ACTIVITY_NEW_TASK |
                        Intent.FLAG_ACTIVITY_CLEAR_TASK |
                        Intent.FLAG_ACTIVITY_NO_HISTORY|
                        Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS |
                        Intent.FLAG_ACTIVITY_MULTIPLE_TASK);


        context.startActivity(intent);
    }

    public static boolean startFwRequestDialog(String app) {
//        log("API: startRequestActivity: " + app);
//        Context ctx = App.getContext();
//        log("startRequestActivity");
//        Intent intent = new Intent(ctx, FwRequestDialog.class);
//        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK|Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
//
//        intent.putExtra("app",app);
//
//        boolean result = true;
//        try {
//            ctx.startActivity(intent);
//        } catch(Exception e) {
//            log("startFwRequestDialog fail: " + e.getMessage());
//            result = false;
//        }
//        return  result;


        Context ctx =App.getContext();

//        App.keepRoute();
//        App.flutterEngine.getNavigationChannel().setInitialRoute("/netreq");
        //05-10 12:23:39.867  8057  8477 D AndroidProtocolManager: API: jniMethodCall fail: java.lang.RuntimeException: Methods marked with @UiThread must be executed on the main thread. Current thread: tun-thread

        Intent intent = FlutterActivity.withCachedEngine("my_engine_id")
                .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
                .build(ctx);
//        intent.putExtra("app","com.tencent.mm");

//        log("Intent.FLAG_ACTIVITY_CLEAR_TASK");
        intent.setFlags(
                Intent.FLAG_ACTIVITY_NEW_TASK |
                        Intent.FLAG_ACTIVITY_CLEAR_TASK |
                        Intent.FLAG_ACTIVITY_NO_HISTORY|
                        Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS |
                        Intent.FLAG_ACTIVITY_MULTIPLE_TASK);

        boolean result = true;
        try {
            ctx.startActivity(intent);
        } catch(Exception e) {
            log("startFwRequestDialog fail: " + e.getMessage());
            result = false;
        }
        return  result;
    }
}
