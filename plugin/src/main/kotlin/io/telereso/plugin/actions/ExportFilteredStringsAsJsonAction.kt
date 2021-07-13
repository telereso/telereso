package io.telereso.plugin.actions

import com.intellij.notification.NotificationDisplayType
import com.intellij.notification.NotificationGroup
import com.intellij.notification.NotificationType
import com.intellij.openapi.actionSystem.AnAction
import com.intellij.openapi.actionSystem.AnActionEvent
import com.intellij.openapi.module.ModuleUtil
import com.intellij.openapi.project.Project
import com.intellij.psi.search.FilenameIndex

import io.telereso.plugin.util.TeleresoFiles
import com.intellij.psi.search.GlobalSearchScope
import java.io.File
import java.awt.BorderLayout

import java.awt.Dimension

import javax.swing.JPanel

import javax.swing.JComponent

import com.intellij.openapi.ui.DialogWrapper
import com.intellij.openapi.ui.ValidationInfo
import org.jetbrains.annotations.Nullable
import javax.swing.JEditorPane


class ExportFilteredStringsAsJsonAction : AnAction() {


    override fun actionPerformed(e: AnActionEvent) {
        // Get all the required data from data keys
        // Get all the required data from data keys
        val project = e.project ?: return
        FilterDialog(project).show()
    }
}


class FilterDialog(val project: Project) : DialogWrapper(true) {
    private val label = JEditorPane()
    override fun createCenterPanel(): JComponent {
        val dialogPanel = JPanel(BorderLayout())
        dialogPanel.preferredSize = Dimension(500, 100)
        label.preferredSize = Dimension(100, 50)
        dialogPanel.add(label, BorderLayout.CENTER)
        return dialogPanel
    }

    override fun doValidate(): ValidationInfo? {
        if (label.text.trim().isNullOrBlank())
            return ValidationInfo("Empty keys")

        return super.doValidate()
    }

    override fun doOKAction() {
        super.doOKAction()

        val keys = label.text.split(",").toList().map { it.toLowerCase().trim() }


        var message = "File exported"
        TeleresoFiles.exportStringsAsJson(project, keys = keys)?.let { message = it }

        val noti = NotificationGroup("telereso_exported", NotificationDisplayType.BALLOON, true)
        noti.createNotification("Telereso", message, NotificationType.INFORMATION, null).notify(project)

    }

    init {
        title = "Add comma separated strings key , tab_home,tab_wallet...etc"
        init()
    }
}