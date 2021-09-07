package com.cloudmonad.inspect;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.os.Bundle;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class FloatActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_float);
    }

    public FlutterEngine provideFlutterEngine(@NonNull Context context) {
        App app = (App)context.getApplicationContext();
        return app.engineFloat;
    }


}