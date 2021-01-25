package io.telereso.plugin.services

import com.intellij.openapi.project.Project
import io.telereso.plugin.TeleresoBundle


class TeleresoProjectService(project: Project) {

    init {
        println(TeleresoBundle.message("projectService", project.name))
    }
}