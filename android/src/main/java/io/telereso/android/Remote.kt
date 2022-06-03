package io.telereso.android

interface Remote {
    fun getName(): String
    fun getString(key: String): String
    fun getKeysByPrefix(prefix: String): Set<String>
}