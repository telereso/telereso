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
        }).enableRealTimeChanges().enableDrawableLog();
    }
}
