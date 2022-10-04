package io.telereso.android.views

import android.content.Context
import android.util.AttributeSet
import androidx.annotation.IdRes
import com.google.android.material.imageview.ShapeableImageView
import io.telereso.android.*

open class RemoteShapeableImageView @JvmOverloads constructor(
        context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = 0
) : ShapeableImageView(context, attrs, defStyleAttr) {

    @IdRes
    private var resId: Int? = null

    private val changeListener = object : RemoteChanges {
        override fun onRemoteUpdate() {
            post { resId?.let { setImageResource(it) } }
        }
    }

    override fun setImageResource(@IdRes resId: Int) {
        this.resId = resId
        setRemoteImageResource(resId)
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