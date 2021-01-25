package io.telereso.plugin.util

import com.google.gson.Gson
import com.intellij.openapi.project.Project
import com.intellij.psi.xml.XmlFile
import com.intellij.util.xml.DomElement
import com.intellij.util.xml.DomManager

object Converters {

    fun xmlToJson(xmlFile: XmlFile): String {
        val map = HashMap<String, String>()
        xmlFile.document?.rootTag?.findSubTags("string")?.forEach {
            map[it.getAttribute("name")?.value ?: ""] = it.value.trimmedText
        }
        return Gson().toJson(map)
    }
}

