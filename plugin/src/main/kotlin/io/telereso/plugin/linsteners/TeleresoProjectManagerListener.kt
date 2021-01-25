package io.telereso.plugin.linsteners

import com.intellij.openapi.components.service
import com.intellij.openapi.project.Project
import com.intellij.openapi.project.ProjectManagerListener
import io.telereso.plugin.services.TeleresoProjectService

internal class TeleresoProjectManagerListener : ProjectManagerListener {

    override fun projectOpened(project: Project) {
        project.service<TeleresoProjectService>()
    }
}