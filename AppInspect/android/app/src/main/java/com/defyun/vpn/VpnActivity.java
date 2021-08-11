package com.defyun.vpn;

import android.app.Activity;
import android.app.ActivityManager;
import android.content.Context;
import android.content.Intent;
import android.net.VpnService;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import java.util.Arrays;
import java.util.List;

public class VpnActivity extends Activity {

    static String TAG = "VpnActivity";
    static void log(String msg) {
        android.util.Log.d("VpnActivity", msg);
    }

    Bundle mVpnParas = null;

    public static void killAppProcesses(Context context) {
        Log.i(TAG, "killAppProcesses; ");

        int myPid = android.os.Process.myPid();
        ActivityManager activityManager = (ActivityManager)
                context.getSystemService(Context.ACTIVITY_SERVICE);
        if (activityManager != null) {
            List<ActivityManager.RunningAppProcessInfo> processInfos =
                    activityManager.getRunningAppProcesses();
            if (processInfos != null) {
                String packageName = context.getPackageName();
                for (ActivityManager.RunningAppProcessInfo processInfo : processInfos) {
                    if (processInfo.pid != myPid) { // Current process will be killed last
                        if (processInfo.pkgList != null) {
                            List<String> packageNames = Arrays.asList(processInfo.pkgList);
                            if (packageNames.contains(packageName)) {
                                Log.i(TAG, "killAppProcesses; killing process: " + processInfo.pid);
                                android.os.Process.killProcess(processInfo.pid);
                            }
                        }
                    }
                }
            }
        }

        Log.i(TAG, "killAppProcesses; not killing my process: " + myPid);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        Bundle extras = getIntent().getExtras();
        mVpnParas = extras;
//        log("getIntent().getExtras() " + extras);
        boolean isStop = extras.getBoolean("isStop");
        if (isStop) {
            log("VpnActivity: stopVpn:  myPid:" + android.os.Process.myPid());
            killAppProcesses(this);
            finish();
//            log("VpnActivity stop vpn");
//            Intent intent = getServiceIntent().setAction("ACTION_STOP");
//            intent.putExtras(extras);
//            startService(intent);
//            Toast.makeText(this, "stop", Toast.LENGTH_SHORT).show();

        } else {
//            log("VpnActivity start vpn");
            Intent intent = VpnService.prepare(this);
            if (intent != null) {
                intent.putExtras(extras);
                startActivityForResult(intent, 0);
            } else {
                Intent data = new Intent();
                data.putExtras(extras);
                onActivityResult(0, RESULT_OK, data);
            }
        }
    }

    @Override
    protected void onActivityResult(int request, int result, Intent data) {
        super.onActivityResult(request, result, data);
        if (result == RESULT_OK) {
//            startService(getServiceIntent().setAction(ToyVpnService.ACTION_START));
//            Toast.makeText(this, "start", Toast.LENGTH_SHORT).show();
            Intent intent = getServiceIntent().setAction("ACTION_START");
            intent.putExtras(mVpnParas);

            startService(intent);

        }
        finish();
    }

    private Intent getServiceIntent() {
        return new Intent(this, ReVpnService.class);
    }


}