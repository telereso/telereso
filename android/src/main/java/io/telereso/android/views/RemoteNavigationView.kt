package io.telereso.android.views

import android.content.Context
import android.content.res.XmlResourceParser
import android.util.AttributeSet
import android.util.Xml
import android.view.InflateException
import android.view.Menu
import androidx.annotation.IdRes
import androidx.annotation.StringRes
import androidx.appcompat.R
import com.google.android.material.navigation.NavigationView
import io.telereso.android.*
import org.xmlpull.v1.XmlPullParser
import org.xmlpull.v1.XmlPullParserException
import java.io.IOException

open class RemoteNavigationView @JvmOverloads constructor(
        context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = com.google.android.material.R.attr.bottomNavigationStyle
) : NavigationView(context, attrs, defStyleAttr) {

    private var menuId: Int? = null

    private val chaneListener = object : RemoteChanges {
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
        addChangeListener(chaneListener)
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        removeChangeListener(chaneListener)
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