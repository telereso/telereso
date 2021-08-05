package io.telereso.android.views

import android.content.Context
import android.util.AttributeSet
import androidx.annotation.IdRes
import androidx.appcompat.widget.AppCompatImageView
import io.telereso.android.*

open class RemoteImageView @JvmOverloads constructor(
        context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = 0
) : AppCompatImageView(context, attrs, defStyleAttr) {

    @IdRes
    private var resId: Int? = null

    private val chaneListener = object : RemoteChanges {
        override fun onRemoteUpdate() {
            post { resId?.let { setImageResource(it) } }
        }
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