package com.cloudmonad.inspect;

import android.app.usage.StorageStats;
import android.app.usage.StorageStatsManager;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.os.Bundle;
import android.text.format.Formatter;
import android.util.Log;


import com.microsoft.appcenter.AppCenter;
import com.microsoft.appcenter.analytics.Analytics;
import com.microsoft.appcenter.crashes.Crashes;
import com.microsoft.appcenter.crashes.model.TestCrashException;

import java.lang.reflect.Method;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {

    static void log(String msg) {
        android.util.Log.d("MainActivity", msg);
    }

//    public void pm_test()  {
//        Context ctx = App.getContext();
//        try {
//            android.content.pm.PackageManager pm = App.getContext().getPackageManager();
//            final StorageStatsManager storageStatsManager = (StorageStatsManager) getSystemService(Context.STORAGE_STATS_SERVICE);
//
//
////           pm.getInstallerPackageName();
//            List<ApplicationInfo> packages = pm.getInstalledApplications(0);
////            pm.getPackageInfo("", 0).lastUpdateTime;
//
//            long total = 0;
//
//            long start1 = System.currentTimeMillis();
//
//
//            List<String>  list = java.util.Arrays.asList("com.tencent.mm","com.miui.weather2","com.duowan.kiwi");
//
//            for (ApplicationInfo appInfo : packages ) {
//                if( !list.contains(appInfo.packageName)) {
//                    continue;
//                }
//
//                PackageInfo info = pm.getPackageInfo(appInfo.packageName,0);
//
//                log("app: " + appInfo.packageName);
//                log("lastUpdateTime" + info.lastUpdateTime);
//
//                int uid = appInfo.uid;
//                log("uid" + uid);
//
//
//                final StorageStats storageStats = storageStatsManager.queryStatsForPackage(appInfo.storageUuid, appInfo.packageName, android.os.Process.myUserHandle());
//                Log.d("AppLog", "getAppBytes:" + Formatter.formatShortFileSize(this, storageStats.getAppBytes()) +
//                        " getCacheBytes:" + Formatter.formatShortFileSize(this, storageStats.getCacheBytes()) +
//                        " getDataBytes:" + Formatter.formatShortFileSize(this, storageStats.getDataBytes()));
//
//
//            }
//
//        } catch (Exception e){
//            log("getPackageInfo fail: " + e);
//        };
//    }

    public String getSerialNumber(String name) {
        String serialNumber;

        try {
            Class<?> c = Class.forName("android.os.SystemProperties");
            Method get = c.getMethod("get", String.class);

            serialNumber = (String) get.invoke(c, name);

        } catch (Exception e) {
            e.printStackTrace();
            serialNumber = "";
        }

        return serialNumber;
    }

    protected void onCreate(Bundle savedInstanceState) {


//        pm_test();
        super.onCreate(savedInstanceState);

        log(": " + getSerialNumber("a"));

//        AppCenter.setLogLevel(Log.VERBOSE);
//        log("init AppCenter");
        AppCenter.start(getApplication(), "df41908a-5079-401e-a54f-cb8aa46fa009",
                Analytics.class, Crashes.class);

//        Crashes.generateTestCrash();
    }


}
