package io.telereso.android.views

import android.content.Context
import android.util.AttributeSet
import androidx.annotation.StringRes
import androidx.appcompat.widget.Toolbar
import io.telereso.android.*

open class RemoteToolbar @JvmOverloads constructor(
        context: Context, attrs: AttributeSet? = null
) : Toolbar(context, attrs) {

    @StringRes
    private var titleId: Int? = null

    @StringRes
    private var subTitleId: Int? = null

    private val changeListener = object : RemoteChanges {
        override fun onRemoteUpdate() {
            post { titleId?.let { title = getRemoteString(it) } }
            post { subTitleId?.let { subtitle = getRemoteString(it) } }
        }
    }

    init {
        context.theme.obtainStyledAttributes(
                attrs,
            R.styleable.RemoteToolbar,
                0, 0).apply {
            try {
                getResourceId(R.styleable.RemoteToolbar_android_title, 0).let {
                    if (it != 0)
                        titleId = it
                }
                getResourceId(R.styleable.RemoteToolbar_title, 0).let {
                    if (it != 0)
                        titleId = it
                }
                getResourceId(R.styleable.RemoteToolbar_subtitle, 0).let {
                    if (it != 0)
                        subTitleId = it
                }
            } finally {
                recycle()
            }
        }

        titleId?.let { title = getRemoteString(it) }
        subTitleId?.let { subtitle = getRemoteString(it) }
    }


    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        addChangeListener(changeListener)
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        removeChangeListener(changeListener)
    }


}