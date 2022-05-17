package io.telereso.android.views

import android.content.Context
import android.content.res.XmlResourceParser
import android.util.AttributeSet
import android.util.Xml
import android.view.InflateException
import com.google.android.material.navigation.NavigationView
import io.telereso.android.*
import org.xmlpull.v1.XmlPullParserException
import java.io.IOException

open class RemoteNavigationView @JvmOverloads constructor(
        context: Context, attrs: AttributeSet? = null
) : NavigationView(context, attrs) {

    private var menuId: Int? = null

    private val changeListener = object : RemoteChanges {
        override fun onRemoteUpdate() {
            post {
                menuId?.let {
                    menu.clear()
                    inflateMenu(it)
                }
            }
        }
    }

    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        addChangeListener(changeListener)
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        removeChangeListener(changeListener)
    }

    override fun inflateMenu(resId: Int) {
        super.inflateMenu(resId)
        menuId = resId
        var parser: XmlResourceParser? = null
        try {
            parser = context.resources.getLayout(resId)
            val attrs = Xml.asAttributeSet(parser)
            parseMenu(context,parser, attrs, menu)
        } catch (e: XmlPullParserException) {
            throw  InflateException("Error inflating menu XML", e)
        } catch (e: IOException) {
            throw  InflateException("Error inflating menu XML", e)
        } finally {
            parser?.close()
        }
    }

}