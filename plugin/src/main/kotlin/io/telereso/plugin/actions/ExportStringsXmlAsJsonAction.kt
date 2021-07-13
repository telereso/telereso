package io.telereso.plugin.actions

import com.intellij.notification.NotificationDisplayType
import com.intellij.notification.NotificationGroup
import com.intellij.notification.NotificationType
import com.intellij.openapi.actionSystem.AnAction
import com.intellij.openapi.actionSystem.AnActionEvent
import com.intellij.openapi.actionSystem.CommonDataKeys
import com.intellij.openapi.actionSystem.PlatformDataKeys
import com.intellij.openapi.module.ModuleUtil
import io.telereso.plugin.util.TeleresoFiles

class ExportStringsXmlAsJsonAction : AnAction() {

    override fun update(e: AnActionEvent) {
        super.update(e)
        // Get required data keys
        val project = e.project
        val editor = e.getData(CommonDataKeys.EDITOR)
        val file = e.getData(PlatformDataKeys.VIRTUAL_FILE)
        e.presentation.isEnabledAndVisible = (project != null && editor != null && file?.name == "strings.xml")
    }

    override fun actionPerformed(e: AnActionEvent) {
        // Get all the required data from data keys
        // Get all the required data from data keys
        val editor = e.getRequiredData(CommonDataKeys.EDITOR)
        val file = e.getRequiredData(PlatformDataKeys.VIRTUAL_FILE)

        ModuleUtil.findModuleForFile(file, e.project!!)?.apply {
            val created = TeleresoFiles.exportDocument(e.project!!,name.split(".")[1], file, editor.document.text,true) != null
            val message = if (created) "File exported" else "Failed to export"

            TeleresoFiles.getTeleresoDir(project)?.refresh(false, true)

            val noti = NotificationGroup("telereso_exported", NotificationDisplayType.BALLOON, true)
            noti.createNotification("Telereso", message, NotificationType.INFORMATION, null).notify(e.project)
        }


    }
}