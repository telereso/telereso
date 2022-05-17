package io.telereso.android

interface RemoteChanges {
    fun onRemoteUpdate()
    fun onResourceNotFound(key: String) {}
    fun onException(e:Exception){}
}