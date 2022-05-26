package io.telereso.android

interface Remote {
    fun getString(key: String): String
    fun getKeysByPrefix(prefix: String): Set<String>
}