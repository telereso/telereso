package io.telereso.plugin.actions

import com.intellij.ide.highlighter.XmlFileType
import com.intellij.notification.NotificationDisplayType
import com.intellij.notification.NotificationGroup
import com.intellij.notification.NotificationType
import com.intellij.openapi.actionSystem.AnAction
import com.intellij.openapi.actionSystem.AnActionEvent
import com.intellij.psi.search.FilenameIndex

import io.telereso.plugin.util.TeleresoFiles
import com.intellij.psi.search.GlobalSearchScope


class ExportStringsAsJsonAction : AnAction() {


    override fun actionPerformed(e: AnActionEvent) {
        // Get all the required data from data keys
        // Get all the required data from data keys
        var message = "File exported"

        FilenameIndex.getFilesByName(e.project!!, "strings.xml", GlobalSearchScope.projectScope(e.project!!)).forEach {
            if (!TeleresoFiles.exportDocument(e.project!!, it.virtualFile, it.text)) {
                message = "Failed to export"
                return@forEach
            }
        }

        val noti = NotificationGroup("telereso_exported", NotificationDisplayType.BALLOON, true)
        noti.createNotification("Telereso", message, NotificationType.INFORMATION, null).notify(e.project)
    }
}