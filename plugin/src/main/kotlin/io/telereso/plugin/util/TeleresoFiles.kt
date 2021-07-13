package io.telereso.plugin.util

import com.google.gson.Gson
import com.intellij.ide.highlighter.XmlFileType
import com.intellij.openapi.module.ModuleUtil
import com.intellij.openapi.project.Project
import com.intellij.openapi.vfs.LocalFileSystem
import com.intellij.openapi.vfs.VirtualFile
import com.intellij.psi.PsiFileFactory
import com.intellij.psi.search.FilenameIndex
import com.intellij.psi.search.GlobalSearchScope
import com.intellij.psi.xml.XmlFile
import java.io.File

object TeleresoFiles {
    private fun createTeleresoDir(project: Project): File? {
        project.projectFile?.apply {
            val dir = File(parent.parent.path, ".telereso")
            if (!dir.exists()) {
                dir.mkdir()
                parent.parent.refresh(false, false)
            }

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


    private fun createModuleFolder(currentDir: File, module: String): File {
        val moduleDir = File(currentDir, module)
        if (!moduleDir.exists())
            moduleDir.mkdir()
        return moduleDir
    }

    fun createStringFile(dir: File, fileName: String, txt: String): File {
        val f = File(dir, fileName)
        f.delete()
        f.createNewFile()
        f.writeText(txt)
        return f
    }

    fun exportDocument(
        project: Project,
        module: String,
        file: VirtualFile,
        txt: String,
        singleFile: Boolean = false,
        keys: List<String>? = null
    ): File? {
        val document = PsiFileFactory.getInstance(project)
            .createFileFromText(file.name, XmlFileType.INSTANCE, txt) as XmlFile
        val json = Converters.xmlToJson(document, keys)

        if (json == "{}") return null

        val local = file.parent.name.split("-").toMutableList()
        local.removeAt(0)
        if (local.isEmpty()) {
            local.add("default")
        }
        var fileName = "strings_${local.joinToString("_") { it.toLowerCase() }}.json"

        return if (singleFile) {
            fileName = "${module}_$fileName"
            createTeleresoDir(project)?.let { dir ->
                createStringFile(dir, fileName, json)
            }
        } else {
            createStringsFolder(project)?.let { dir -> createModuleFolder(dir, module) }?.let { dir ->
                createStringFile(dir, fileName, json)
            }
        }

    }

    fun clearStringsFolder(project: Project): Boolean {
        createTeleresoDir(project)?.let { dir ->
            File(dir, "strings").deleteRecursively()
            return true
        }
        return false
    }

    fun saveMergedStrings(project: Project, allFiles: List<File>) {
        val gson = Gson()
        val map = hashMapOf<String, HashMap<String, String>>()
        allFiles.forEach {
            val local = it.name.split(".")[0].split("_")[1]
            val m = map.getOrDefault(local, hashMapOf())
            m.putAll(Converters.jsonToMap(it.readText()))
            map[local] = m
        }
        createStringsFolder(project)?.let { dir ->
            val mergedDir = File(dir, "merged")
            mergedDir.deleteRecursively()
            mergedDir.mkdir()
            map.forEach { entry ->
                val f = File(mergedDir, "strings_${entry.key}.json")
                f.createNewFile()
                f.writeText(gson.toJson(entry.value))
            }
        }
    }

    fun getTeleresoDir(project: Project): VirtualFile? {
        project.projectFile?.apply {
            val dir = File(parent.parent.path, ".telereso")
            if (dir.exists())
                return LocalFileSystem.getInstance().findFileByIoFile(dir)
        }
        return null
    }


    fun exportStringsAsJson(project: Project, isSingleFile: Boolean = false, keys: List<String>? = null): String? {
        var message: String? = null
        clearStringsFolder(project)
        val allFiles = mutableListOf<File>()
        FilenameIndex.getFilesByName(project, "strings.xml", GlobalSearchScope.projectScope(project)).forEach {
            ModuleUtil.findModuleForFile(it.virtualFile, project)?.apply {
                val modelName = if (name.contains(".")) name.split(".")[1] else name
                val f = TeleresoFiles.exportDocument(project, modelName, it.virtualFile, it.text, isSingleFile, keys)
                if (f == null) {
                    message = "Failed to export"
                    return@forEach
                } else
                    allFiles.add(f)
            }

        }
        saveMergedStrings(project, allFiles)
        getTeleresoDir(project)?.refresh(false, true)
        return message
    }
}