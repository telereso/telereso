package io.telereso.plugin.util

import com.google.gson.Gson
import com.intellij.openapi.project.Project
import com.intellij.psi.xml.XmlFile
import com.intellij.util.xml.DomElement
import com.intellij.util.xml.DomManager

object Converters {

    fun xmlToJson(xmlFile: XmlFile, keys: List<String>? = null): String {
        val map = HashMap<String, String>()
        xmlFile.document?.rootTag?.findSubTags("string")?.forEach {
            val key = it.getAttribute("name")?.value ?: ""
            if (keys == null || keys.contains(key))
                map[key] = it.value.trimmedText
        }
        return Gson().toJson(map)
    }

    fun jsonToMap(txt: String): Map<String, String> {
        return Gson().fromJson(txt, Map::class.java) as Map<String, String>
    }
}

