package io.telereso.android

import android.content.Context
import android.content.res.Resources
import androidx.annotation.StyleRes
import androidx.appcompat.view.ContextThemeWrapper

class RemoteContextThemeWrapper(private val base: Context, @StyleRes themeResId: Int) :
    ContextThemeWrapper(base, themeResId) {

    constructor(base: Context) : this(base, R.style.Telereso_Theme_AppCompat_Empty)

    override fun getResources(): Resources {
        base.theme
        return RemoteResource(base.resources)
    }

}
