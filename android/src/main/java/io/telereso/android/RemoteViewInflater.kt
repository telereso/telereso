package io.telereso.android

import android.content.Context
import android.util.AttributeSet
import android.view.View
import androidx.appcompat.app.AppCompatViewInflater
import androidx.appcompat.widget.AppCompatButton
import androidx.appcompat.widget.AppCompatEditText
import androidx.appcompat.widget.AppCompatTextView
import io.telereso.android.views.*

open class RemoteViewInflater : AppCompatViewInflater() {


    override fun createView(context: Context, name: String?, attrs: AttributeSet): View? {
        return when (name) {
            "androidx.appcompat.widget.AppCompatTextView" -> createTextView(context, attrs)
            "androidx.appcompat.widget.AppCompatEditText" -> createEditText(context, attrs)
            "androidx.appcompat.widget.AppCompatButton" -> createButton(context, attrs)
            "com.google.android.material.bottomnavigation.BottomNavigationView" -> createBottomNavigation(context, attrs)
            "com.google.android.material.navigation.NavigationView" -> createNavigation(context, attrs)
            else -> super.createView(context, name, attrs)
        }

    }

    override fun createTextView(context: Context, attrs: AttributeSet?): AppCompatTextView {
        return RemoteTextView(context, attrs)
    }

    override fun createEditText(context: Context, attrs: AttributeSet?): AppCompatEditText {
        return RemoteEditText(context, attrs)
    }

    override fun createButton(context: Context, attrs: AttributeSet?): AppCompatButton {
        return RemoteButton(context, attrs)
    }

    protected open fun createBottomNavigation(context: Context, attrs: AttributeSet?): RemoteBottomNavigationView {
        return RemoteBottomNavigationView(context, attrs)
    }
    protected open fun createNavigation(context: Context, attrs: AttributeSet?): RemoteNavigationView {
        return RemoteNavigationView(context, attrs)
    }
}