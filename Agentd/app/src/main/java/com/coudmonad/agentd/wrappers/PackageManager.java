package com.coudmonad.agentd.wrappers;

import android.content.pm.ApplicationInfo;
import android.content.pm.ParceledListSlice;
import android.graphics.drawable.Drawable;
import android.os.IInterface;
import android.view.InputEvent;
//import android.content.pm.ParceledListSlice;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

public class PackageManager {
    private final IInterface manager;

    private Method installedApplicationsMethod;

    static void log(String msg) {
        System.out.println(msg);
    }

    public PackageManager(IInterface manager) {
        this.manager = manager;
    }

    private Method getInstalledApplicationsMethod() throws NoSuchMethodException {
        if (installedApplicationsMethod == null) {

            Class<?> cls = manager.getClass();
//            log("cls " + cls.toString());
            for (Method mtd : cls.getDeclaredMethods() )  {
                log("method: " + mtd.toString());
                if(mtd.getName() == "getInstalledApplications") {
                    int cnt = 0 ;
                    try {
                        cnt = mtd.getParameterCount();
                    } catch(Exception e) {
                    }

                    log("mtd: " + mtd.toString() + " " + cnt);
                    return mtd;
                }
            }
            installedApplicationsMethod = manager.getClass().getMethod("getInstalledApplications", int.class);
           log("getInstalledApplicationsMethod " + installedApplicationsMethod);
        }
        return installedApplicationsMethod;
    }

    public void listFun() {
        try {
            for(Method mtd: manager.getClass().getDeclaredMethods()) {
                log("listFun: " + mtd.getName());
            }


        } catch (Exception e) {
            log("listFun mtd fail: " + e.toString());

        }
    }

//    public  Drawable getApplicationIcon(ApplicationInfo info) {
        public  void getApplicationIcon(ApplicationInfo info) {
        try {
            Method method = manager.getClass().getMethod("getApplicationIcon",ApplicationInfo.class);
            log("getApplicationIcon mtd: " + method.getName());

        } catch (Exception e) {
            log("getApplicationIcon mtd fail: " + e.toString());

        }
    }


    public  List<ApplicationInfo> getInstalledApplications(int flags, int userid) {
        try {
//            Method method = getInstalledApplicationsMethod();
            Method method = manager.getClass().getMethod("getInstalledApplications", int.class, int.class);
            log("getInstalledApplications mtd: "+method.toString());

            ParceledListSlice res = (ParceledListSlice)method.invoke(manager, flags,userid);
            log("getInstalledApplications: " + res);
            List<ApplicationInfo> res2 = res.getList();
            log("getInstalledApplications: " + res2.size());
            return  res2;

        } catch (InvocationTargetException | IllegalAccessException | NoSuchMethodException e) {
//            Ln.e("Could not invoke method", e);
            log("Could not invoke method" + e.toString());

            return new ArrayList<ApplicationInfo>();

        }
    }

}
