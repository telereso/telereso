package io.github.froger.instamaterial.ui.activity;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import io.github.froger.instamaterial.R;
import io.telereso.android.Telereso;

public class SplashActivity extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        Telereso.init(this, () -> {
            startActivity(new Intent(this, MainActivity.class));
            finish();
            return null;
        }).enableRealTimeChanges()
                .addCustomEndpoint("https://firebasestorage.googleapis.com/v0/b/instamaterial-2eb76.appspot.com/o/strings%20(1).json?alt=media&token=d7479b83-f185-4fa3-8b6c-50c1f142131a")
                .addCustomEndpoint("https://firebasestorage.googleapis.com/v0/b/instamaterial-2eb76.appspot.com/o/strings_2.json?alt=media&token=fcef2387-17ed-4860-b7dd-75b9845c472c");
    }
}
