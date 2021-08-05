package io.telereso.android.views

import android.content.Context
import android.util.AttributeSet
import android.util.Log
import androidx.annotation.IdRes
import androidx.appcompat.widget.AppCompatImageButton
import io.telereso.android.*

open class RemoteImageButton @JvmOverloads constructor(
        context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = R.attr.imageButtonStyle
) : AppCompatImageButton(context, attrs, defStyleAttr) {

    @IdRes
    private var resId: Int? = null

    private val chaneListener = object : RemoteChanges {
        override fun onRemoteUpdate() {
            post { resId?.let { setImageResource(it) } }
        }
    }

    init {
        context.theme.obtainStyledAttributes(
                attrs,
                R.styleable.RemoteFloatingActionButton,
                0, 0).apply {
            try {
                getResourceId(R.styleable.RemoteFloatingActionButton_android_src, 0).let {
                    if (it != 0)
                        resId = it
                }
                getResourceId(R.styleable.RemoteFloatingActionButton_srcCompat, 0).let {
                    if (it != 0)
                        resId = it
                }
            } finally {
                recycle()
            }
        }
        resId?.let { setImageResource(it) }
    }


    override fun setImageResource(resId: Int) {
        this.resId = resId
        setRemoteImageResource(resId)
    }

    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        addChangeListener(chaneListener)
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        removeChangeListener(chaneListener)
    }


}