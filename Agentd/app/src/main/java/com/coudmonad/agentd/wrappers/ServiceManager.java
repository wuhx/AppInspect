package com.coudmonad.agentd.wrappers;

import android.annotation.SuppressLint;
import android.os.IBinder;
import android.os.IInterface;
import java.lang.reflect.Method;

@SuppressLint("PrivateApi,DiscouragedPrivateApi")
public final class ServiceManager {

    static void log(String msg) {
        System.out.println(msg);
    }

    public static final String PACKAGE_NAME = "com.android.shell";
    public static final int USER_ID = 0;

    private final Method getServiceMethod;

    private InputManager inputManager;
    private PackageManager packageManager;

    public ServiceManager() {
        try {
            getServiceMethod = Class.forName("android.os.ServiceManager").getDeclaredMethod("getService", String.class);
        } catch (Exception e) {
            throw new AssertionError(e);
        }
    }

    private IInterface getService(String service, String type) {
        try {
            IBinder binder = (IBinder) getServiceMethod.invoke(null, service);
            Method asInterfaceMethod = Class.forName(type + "$Stub").getMethod("asInterface", IBinder.class);
            return (IInterface) asInterfaceMethod.invoke(null, binder);
        } catch (Exception e) {
            throw new AssertionError(e);
        }
    }

    public InputManager getInputManager() {
        if (inputManager == null) {
            IInterface service =getService("input", "android.hardware.input.IInputManager");
            inputManager = new InputManager(service);
        }
        return inputManager;
    }

    public PackageManager getpackageManager() {
        if (packageManager == null) {
            IInterface service = getService("package", "android.content.pm.IPackageManager");
            log("PM service:" + service.toString());
            packageManager = new PackageManager(service);
        }
        return packageManager;
    }


}
