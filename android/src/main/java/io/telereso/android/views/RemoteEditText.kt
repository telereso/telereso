package io.telereso.android.views

import android.content.Context
import android.util.AttributeSet
import androidx.annotation.StringRes
import androidx.appcompat.widget.AppCompatEditText
import io.telereso.android.R
import io.telereso.android.RemoteChanges
import io.telereso.android.Telereso
import io.telereso.android.getRemoteString

open class RemoteEditText @JvmOverloads constructor(
        context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = android.R.attr.editTextStyle
) : AppCompatEditText(context, attrs, defStyleAttr) {
    @StringRes
    private var stringId: Int? = null

    @StringRes
    private var hintId: Int? = null

    private val chaneListener = object : RemoteChanges {
        override fun onRemoteUpdate() {
            post {
                stringId?.let { setText(getRemoteString(it)) }
                hintId?.let { hint = getRemoteString(it) }
            }
        }
    }

    init {
        context.theme.obtainStyledAttributes(
                attrs,
                R.styleable.RemoteEditText,
                0, 0).apply {
            try {
                getResourceId(R.styleable.RemoteEditText_android_text, 0).let {
                    if (it != 0)
                        stringId = it
                }
                getResourceId(R.styleable.RemoteEditText_android_hint, 0).let {
                    if (it != 0)
                        hintId = it
                }
            } finally {
                recycle()
            }
        }

        stringId?.let { setText(getRemoteString(it)) }
        hintId?.let { hint = getRemoteString(it) }


    }


    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        Telereso.addChangeListener(chaneListener)
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        Telereso.removeChangeListener(chaneListener)
    }
}