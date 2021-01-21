package io.telereso.android

import android.content.Context
import android.content.ContextWrapper
import android.content.res.Resources

class RemoteContextWrapper(private val base: Context) : ContextWrapper(base) {

    override fun getResources(): Resources {
        return RemoteResource(base.resources)
    }

}
