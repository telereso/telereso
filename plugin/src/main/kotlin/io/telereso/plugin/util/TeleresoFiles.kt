package io.telereso.plugin.util

import com.intellij.ide.highlighter.XmlFileType
import com.intellij.openapi.project.Project
import com.intellij.openapi.vfs.VirtualFile
import com.intellij.psi.PsiFileFactory
import com.intellij.psi.xml.XmlFile
import org.jetbrains.annotations.NotNull
import java.io.File

object TeleresoFiles {
    private fun createTeleresoDir(project: Project): File? {
        project.projectFile?.apply {
            val dir = File(parent.parent.path, ".telereso")
            if (!dir.exists())
                dir.mkdir()
            return dir
        }
        return null
    }

    private fun clearTeleresoDir(project: Project) {
        project.projectFile?.apply {
            val dir = File(parent.parent.path, ".telereso")
            if (!dir.exists())
                dir.deleteRecursively()
            return
        }
    }

    private fun createStringsFolder(project: Project): File? {
        createTeleresoDir(project)?.let { dir ->
            val stringsDir = File(dir, "strings")
            if (!stringsDir.exists())
                stringsDir.mkdir()
            return stringsDir
        }
        return null
    }

    fun createStringFile(project: Project, fileName: String, txt: String): Boolean {
        createStringsFolder(project)?.let { dir ->
            val f = File(dir, fileName)
            f.delete()
            f.createNewFile()
            f.writeText(txt)
            return true
        }
        return false
    }

    fun exportDocument(project: Project, file: VirtualFile, txt: String): Boolean {
        val document = PsiFileFactory.getInstance(project)
            .createFileFromText(file.name, XmlFileType.INSTANCE, txt) as XmlFile
        val json = Converters.xmlToJson(document)
        val local = file.parent.name.split("-").getOrNull(1) ?: "en"
        return createStringFile(project, "strings_${local}.json", json)
    }
}