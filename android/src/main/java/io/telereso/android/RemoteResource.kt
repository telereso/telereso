package io.telereso.android

import android.content.res.Resources
import android.graphics.drawable.Drawable

class RemoteResource(res: Resources) : Resources(res.assets, res.displayMetrics, res.configuration) {

//    override fun getDrawable(id: Int, theme: Theme?): Drawable {
//        return Telereso.getRemoteStringOrDefault(Telereso.getLocal(this), getResourceEntryName(id), super.getDrawable(id, theme))
//    }
//
//    override fun getDrawable(id: Int): Drawable {
//        return Telereso.getRemoteStringOrDefault(Telereso.getLocal(this), getResourceEntryName(id), super.getDrawable(id, theme))
//    }

    override fun getString(id: Int): String {
        return Telereso.getRemoteStringOrDefault(Telereso.getLocal(this), getResourceEntryName(id), super.getString(id))
    }

    override fun getString(id: Int, vararg formatArgs: Any?): String {
        return Telereso.getRemoteStringOrDefaultFormat(Telereso.getLocal(this), getResourceEntryName(id), super.getString(id), formatArgs)
    }

}
