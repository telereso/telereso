package io.github.froger.instamaterial;


import androidx.multidex.MultiDexApplication;

import io.telereso.android.Telereso;
import timber.log.Timber;

/**
 * Created by froger_mcs on 05.11.14.
 */
public class InstaMaterialApplication extends MultiDexApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        Timber.plant(new Timber.DebugTree());
        Telereso.init(this);

    }
}
