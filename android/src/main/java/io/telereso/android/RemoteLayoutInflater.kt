package io.telereso.android

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import io.telereso.android.views.*

internal class RemoteLayoutInflater(original: LayoutInflater, newContext: Context) : LayoutInflater(original, newContext) {

    override fun cloneInContext(context: Context): LayoutInflater {
        return RemoteLayoutInflater(this, context)
    }

    override fun onCreateView(viewContext: Context, parent: View?, name: String, attrs: AttributeSet?): View? {
        return when (name) {
            "androidx.appcompat.widget.AppCompatTextView", "TextView" -> RemoteTextView(context, attrs)
            "androidx.appcompat.widget.AppCompatEditText", "EditText" -> RemoteEditText(context, attrs)
            "androidx.appcompat.widget.AppCompatButton", "Button" -> RemoteButton(context, attrs)
            "androidx.appcompat.widget.AppCompatImageView", "ImageView" -> RemoteImageView(context, attrs)
            "androidx.appcompat.widget.AppCompatImageButton", "ImageButton" -> RemoteImageButton(context, attrs)
            "com.google.android.material.bottomnavigation.BottomNavigationView" -> RemoteBottomNavigationView(context, attrs)
            "com.google.android.material.navigation.NavigationView" -> RemoteNavigationView(context, attrs)
            "com.google.android.material.floatingactionbutton.FloatingActionButton" -> RemoteFloatingActionButton(context, attrs)
            "com.google.android.material.imageview.ShapeableImageView" -> RemoteShapeableImageView(context, attrs)
            else -> super.onCreateView(viewContext, parent, name, attrs)
        }
    }

    override fun onCreateView(name: String?, attrs: AttributeSet?): View {
        return super.onCreateView(name, attrs)
    }

    override fun onCreateView(parent: View?, name: String?, attrs: AttributeSet?): View {
        return super.onCreateView(parent, name, attrs)
    }


}