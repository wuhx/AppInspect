package com.coudmonad.agentd;

import android.net.LocalServerSocket;
import android.net.LocalSocket;
import android.util.Log;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;

public class UdsServer {
    private static final String TAG = "UdsServer";

    private static final String SOCKET_NAME = "demo.localsocket";
    private LocalServerSocket mServerSocket = null;
    private LocalSocket mSocket;

    void start() {
        createServerSocket();
        try {
            mSocket = mServerSocket.accept();
        } catch (IOException e1) {
            e1.printStackTrace();
        }

        while (true) {
            try {
                byte[] buffer = new byte[1024];
                InputStream mInputStream = mSocket.getInputStream();
                int count = mInputStream.read(buffer);
                String key = new String(Arrays.copyOfRange(buffer, 0, count));
                Log.d(TAG, "ServerActivity mSocketOutStream==" + key);
            } catch (IOException e) {
                Log.d(TAG, "exception==" + e.fillInStackTrace().getMessage());
                e.printStackTrace();
            }
        }


    }


    private void createServerSocket() {

        if (mServerSocket == null) {
            try {

                mServerSocket = new LocalServerSocket(SOCKET_NAME);
            } catch (IOException ex) {
            }
        }
    }


}
