package io.telereso.android.views

import android.content.Context
import android.util.AttributeSet
import androidx.annotation.StringRes
import androidx.appcompat.widget.AppCompatButton
import io.telereso.android.*

open class RemoteButton @JvmOverloads constructor(
        context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = android.R.attr.buttonStyle
) : AppCompatButton(context, attrs, defStyleAttr) {

    @StringRes
    private var stringId: Int? = null

    private val changeListener = object : RemoteChanges {
        override fun onRemoteUpdate() {
            post {
                stringId?.let { text = getRemoteString(it) }
            }
        }
    }

    init {
        context.theme.obtainStyledAttributes(
                attrs,
                R.styleable.RemoteButton,
                0, 0).apply {
            try {
                getResourceId(R.styleable.RemoteButton_android_text, 0).let {
                    if (it != 0)
                        stringId = it
                }
            } finally {
                recycle()
            }
        }

        stringId?.let { text = getRemoteString(it) }

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