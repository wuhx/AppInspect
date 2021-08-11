package com.coudmonad.agentd;

import android.util.Log;

import java.net.*;
import java.io.*;

public class EchoServer {
    Thread mThread;
    public static final String TAG = "Agentd-EchoServer";

    public void start() {
        Log.d(TAG, "EchoServer start");

        mThread = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    runServer();
                } catch(Exception e) {
                    Log.d(TAG, "EchoServer start fail: " + e.getMessage());

                }
            }
        });
        mThread.start();
    }

    public void runServer() throws IOException {

        int portNumber = 8080;
        ServerSocket serverSocket = new ServerSocket(portNumber);
        Socket clientSocket = serverSocket.accept();
        Log.d(TAG, "EchoServer accept(): " + clientSocket.toString());


        try (


                PrintWriter out =
                        new PrintWriter(clientSocket.getOutputStream(), true);
                BufferedReader in = new BufferedReader(
                        new InputStreamReader(clientSocket.getInputStream()));
        ) {
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                out.println(inputLine);
            }
        } catch (IOException e) {
            System.out.println("Exception caught when trying to listen on port "
                    + portNumber + " or listening for a connection");
            System.out.println(e.getMessage());
        }
    }
}