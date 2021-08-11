package com.defyun.channel;


import com.defyun.pb.AppManagerProtocol;

import com.google.protobuf.CodedOutputStream;
import com.google.protobuf.GeneratedMessageLite;

import java.io.IOException;
import java.nio.ByteBuffer;

import  com.defyun.channel.impl.PackageManager;

public class AndroidProtocolManager {

    static void log(String msg) {
        android.util.Log.d("AndroidProtocolManager", msg);
    }

    public static ByteBuffer toByteBuffer(GeneratedMessageLite data) {
        try {
            ByteBuffer result = ByteBuffer.allocateDirect(data.getSerializedSize());

            final CodedOutputStream output = CodedOutputStream.newInstance(result);
            data.writeTo(output);
            output.checkNoSpaceLeft();
            return result;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }


    public static ByteBuffer handle(ByteBuffer input) {
        try {
            AppManagerProtocol.RequestApi api = AppManagerProtocol.RequestApi.parseFrom(input);
            if (api.hasPackageInfoReq()) {
                return  PackageManager.handle(api);
            }  else{
                log("API: not AppManagerProtocol ");
                throw new RuntimeException("unimplemented!");
            }

        } catch (Exception e) {
            log("API: jniMethodCall fail: " + e);
            return ByteBuffer.allocate(0);
        }

    }




//    static AppManagerProtocol.PackageInfoList getPackageInfoList(boolean not_system_app)  {
//        log("###### vpn test!");
//        Context ctx = App.getContext();
//
//        AppManagerProtocol.PackageInfoList.Builder builder = AppManagerProtocol.PackageInfoList.newBuilder();
//
//        return builder.build();
//    }


}