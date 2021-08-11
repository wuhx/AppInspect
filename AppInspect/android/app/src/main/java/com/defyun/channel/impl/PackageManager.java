package com.defyun.channel.impl;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;

import com.defyun.channel.AndroidProtocolManager;
import com.defyun.pb.AppManagerProtocol;
import com.cloudmonad.inspect.App;
import com.google.protobuf.ByteString;
import com.google.protobuf.GeneratedMessageLite;

import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.List;

public class PackageManager {

    static void log(String msg) {
        android.util.Log.d("PackageManager", msg);
    }

    public static ByteBuffer handle(AppManagerProtocol.RequestApi api) {
        AppManagerProtocol.PackageInfoReq req = api.getPackageInfoReq();
//        log("API: jvm PackageInfoReq: " + req.getNotSystemApp());
        long start = System.currentTimeMillis();
        AppManagerProtocol.PackageInfoList data = PackageManager.getPackageInfoList(req.getNotSystemApp(), req.getSelectedPackageListList(), req.getQuick());
//        log("API: getPackageInfoList  use " + (System.currentTimeMillis() - start) + " ms");
//        log("API: getPackageInfoList  find" + data.getPkgInfoListCount() + " apps!");
        return AndroidProtocolManager.toByteBuffer(data);
    }


    static Bitmap drawbleToBitmap(Drawable drawable) {
        Bitmap bitmap;

        if(drawable instanceof BitmapDrawable) {
            Bitmap bm = ((BitmapDrawable)drawable).getBitmap();
            if(bm != null) {
                return bm;
            }
        }

        if (drawable.getIntrinsicWidth() <= 0 || drawable.getIntrinsicHeight() <= 0) {
            bitmap = Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888); // Single color bitmap will be created of 1x1 pixel
        } else {
            bitmap = Bitmap.createBitmap(drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight(), Bitmap.Config.ARGB_8888);
        }

        Canvas canvas = new Canvas(bitmap);
        drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
        drawable.draw(canvas);
        return bitmap;
    }

    static byte[] iconToByteArray(Drawable drawable) {
        Bitmap bitmap = drawbleToBitmap(drawable);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, baos);
        return baos.toByteArray();
    }

    public static AppManagerProtocol.PackageInfoList getPackageInfoList(boolean not_system_app,List<String> selected_package_list,boolean quick)  {
        Context ctx = App.getContext();
        AppManagerProtocol.PackageInfoList.Builder builder = AppManagerProtocol.PackageInfoList.newBuilder();
        try {
            android.content.pm.PackageManager pm = App.getContext().getPackageManager();

//           pm.getInstallerPackageName()
            List<ApplicationInfo> packages = pm.getInstalledApplications(0);
//            pm.getPackageInfo("", 0).lastUpdateTime;
//            log("AppManagerProtocol find " + packages.size() + " apps");

            long total = 0;

            long start1 = System.currentTimeMillis();

            for (ApplicationInfo appInfo : packages ) {
                //指定app列表非空，并且不是当前app不是指定app
                if (!selected_package_list.isEmpty() && !selected_package_list.contains(appInfo.packageName)) {
                    continue;
                }

//                log("not_system_app: "+not_system_app);
                if (not_system_app & !appInfo.sourceDir.startsWith("/data/app")){
//                    log("ingore system package: " + appInfo.packageName);
//                    log("appInfo.sourceDir: " + appInfo.sourceDir);
                    continue;
                }

                int uid = appInfo.uid;

                PackageInfo pkgInfo = pm.getPackageInfo(appInfo.packageName,0);


//                log("package: " + appInfo.name + " uid" + appInfo.uid + " data: "+ appInfo.sourceDir);
//                log( "Installed package :" + appInfo.packageName);
//                log("uid: " + pm.getPackageUid(appInfo.packageName,0));


                byte[] icon_bytes = {};
                long start = System.currentTimeMillis();


                if (!quick) {
//                    long start2 = System.currentTimeMillis();
                    Drawable icon = pm.getApplicationIcon(appInfo);
                    icon_bytes = iconToByteArray(icon); //12ms
//                    log("timing: packageInfopackageInfo icon for:" + appInfo.packageName + " :"  + (System.currentTimeMillis() - start2) + " ms!");

                }

                long end = (System.currentTimeMillis() - start);
                total += end;
//                log("timing:  iconToByteArray use " + end  + " ms!");

                String name = appInfo.loadLabel(pm).toString();

//                if(true) {
//                    if( appInfo.packageName.contains("luojilab") || appInfo.packageName.contains("tencent.mm")) {
//                    String dir = appInfo.dataDir;
//                    log("APP: " + name + " dataDir: " + dir);
//                    dir = appInfo.sourceDir;
//                    log("APP: " + name + " sourceDir: " + dir);
//                    dir = appInfo.nativeLibraryDir;
//                    log("APP: " + name + " nativeLibraryDir: " + dir);
//
//                    dir = appInfo.publicSourceDir;
//                    log("APP: " + name + " publicSourceDir: " + dir);
//
//                    dir = appInfo.permission;
//                    log("APP: " + name + " permission: " + dir);
//
//                    dir = appInfo.deviceProtectedDataDir;
//                    log("APP: " + name + " deviceProtectedDataDir: " + dir);
//
//                    int res  = appInfo.descriptionRes;
//                    log("APP: " + name + " descriptionRes: " + res);
//
//                    res = appInfo.minSdkVersion;
//                    log("APP: " + name + " minSdkVersion: " + res);
//
////
//                    log("APP: " + name + " sharedLibraryFiles: ");
//                    for (String f :appInfo.sharedLibraryFiles) {
//                        log("in APP: " + name + " sharedLibraryFiles: " + f);
//                    }
//
//                }
//



//                log( "Launch Activity :" + pm.getLaunchIntentForPackage(appInfo.packageName));
//                log("set sourceDir: " + appInfo.sourceDir);
                AppManagerProtocol.PackageInfo pkg = AppManagerProtocol.PackageInfo.newBuilder()
                        .setName(name)
                        .setFirstInstallTime(pkgInfo.firstInstallTime)
                        .setLastUpdateTime(pkgInfo.lastUpdateTime)
                        .setSourceDir(appInfo.sourceDir)
                        .setDataDir(appInfo.dataDir)
                        .setMinSdkVersion(appInfo.minSdkVersion)
                        .setTargetSdkVersion(appInfo.targetSdkVersion)
//                        .setCompileSdkVersion(pkgInfo.sdk)
                        .setUid(uid)
                        .setIcon(ByteString.copyFrom(icon_bytes))
                        .setPkgName(appInfo.packageName)
                        .build();

                builder.addPkgInfoList(pkg);
            }


//            log("timing: packageInfopackageInfo use " + (System.currentTimeMillis() - start1) + " ms!");
//            log("timing: packageInfo convert use " + total + " ms!");

        } catch (Exception e){
            log("getPackageInfo fail: " + e);
        };

        return builder.build();
    }


}
