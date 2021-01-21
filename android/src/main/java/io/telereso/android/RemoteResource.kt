package io.telereso.android

import android.content.res.Resources

class RemoteResource(res: Resources) : Resources(res.assets, res.displayMetrics, res.configuration) {

    override fun getString(id: Int): String {
        return Telereso.getRemoteStringOrDefault(getResourceEntryName(id), super.getString(id))
    }

    override fun getString(id: Int, vararg formatArgs: Any?): String {
        return Telereso.getRemoteStringOrDefault(getResourceEntryName(id), super.getString(id), formatArgs)
    }

}
