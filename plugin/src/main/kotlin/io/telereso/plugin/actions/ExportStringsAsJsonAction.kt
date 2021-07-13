package io.telereso.plugin.actions

import com.google.gson.Gson
import com.intellij.ide.highlighter.XmlFileType
import com.intellij.notification.NotificationDisplayType
import com.intellij.notification.NotificationGroup
import com.intellij.notification.NotificationType
import com.intellij.openapi.actionSystem.AnAction
import com.intellij.openapi.actionSystem.AnActionEvent
import com.intellij.openapi.module.ModuleUtil
import com.intellij.psi.search.FilenameIndex

import io.telereso.plugin.util.TeleresoFiles
import com.intellij.psi.search.GlobalSearchScope
import java.io.File


class ExportStringsAsJsonAction : AnAction() {


    override fun actionPerformed(e: AnActionEvent) {
        // Get all the required data from data keys
        val project = e.project ?: return
        var message = "File exported"
        TeleresoFiles.exportStringsAsJson(project)?.let { message = it }

        val noti = NotificationGroup("telereso_exported", NotificationDisplayType.BALLOON, true)
        noti.createNotification("Telereso", message, NotificationType.INFORMATION, null).notify(e.project)
    }
}