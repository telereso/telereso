package io.telereso.android.db

import androidx.room.TypeConverter
import com.google.gson.Gson
import org.json.JSONObject

class Converters {

    private val gson = Gson()

    @TypeConverter
    fun fromString(value: String?): Map<String, String> {
        return gson.fromJson(value ?: "{}", Map::class.java).map {
            it.key.toString() to it.value.toString()
        }.toMap()
    }

    @TypeConverter
    fun toString(map: Map<String, String>): String {
        val json = JSONObject()
        map.forEach {
            json.put(it.key, it.value)
        }
        return json.toString()
    }

    companion object {
        fun toString(map: Map<String, Map<String, String>>): String {
            return toJson(map).toString()
        }

        fun toJson(map: Map<String, Map<String, String>>): JSONObject {
            val json = JSONObject()
            map.forEach {
                json.put(it.key, it.value.toJson())
            }
            return json
        }
    }
}

internal fun Map<String, String>.toJson(): JSONObject {
    val json = JSONObject()
    forEach {
        json.put(it.key, it.value)
    }
    return json
}

internal fun JSONObject?.merge(obj: JSONObject): JSONObject {
    if (this == null) return obj
    for (key in obj.keys()) {
        put(key, obj.get(key))
    }
    return this
}