package io.github.froger.instamaterial.ui.activity

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import io.github.froger.instamaterial.R
import io.telereso.android.Telereso

class SplashActivityKotlin : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)
        Telereso.init(this) {
            startActivity(Intent(this, MainActivity::class.java))
            finish()
        }
    }
}