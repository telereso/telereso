package io.telereso.android

import android.content.Context
import android.content.res.Resources
import android.graphics.drawable.Drawable
import android.util.AttributeSet
import android.util.DisplayMetrics.*
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.ImageView
import androidx.annotation.IdRes
import androidx.annotation.StringRes
import androidx.appcompat.R
import androidx.appcompat.content.res.AppCompatResources
import androidx.fragment.app.Fragment
import com.bumptech.glide.Glide
import com.bumptech.glide.load.DataSource
import com.bumptech.glide.load.engine.GlideException
import com.bumptech.glide.request.RequestListener
import com.bumptech.glide.request.target.Target
import org.xmlpull.v1.XmlPullParser
import org.xmlpull.v1.XmlPullParserException
import java.io.IOException


fun View.getStringKey(@StringRes id: Int): String {
    return context.resources.getResourceEntryName(id)
}

fun View.getKeyName(@IdRes id: Int): String {
    return context.resources.getResourceEntryName(id)
}

fun View.getLocal(): String {
    return Telereso.getLocal(context)
}

fun View.getRemoteString(@StringRes id: Int): String {
    val key = getStringKey(id)
    val default = context.getString(id)
    return Telereso.getRemoteStringOrDefault(getLocal(), key, default)
}

fun MenuItem.setRemoteDrawable(context: Context, resId: Int) {
    if (resId == 0) return
    val key = context.getKeyName(resId)
    val url = Telereso.getRemoteImage(context, key)
    val default = AppCompatResources.getDrawable(context, resId)
    icon = default
    if (!url.isNullOrBlank())
        Glide.with(context).load(url).addListener(object : RequestListener<Drawable> {
            override fun onLoadFailed(e: GlideException?, model: Any?, target: Target<Drawable>?, isFirstResource: Boolean): Boolean {
                Log.e(TAG_DRAWABLES, "failed to load key:$key with url:$url")
                return false
            }

            override fun onResourceReady(resource: Drawable?, model: Any?, target: Target<Drawable>?, dataSource: DataSource?, isFirstResource: Boolean): Boolean {
                resource?.let { icon = resource }
                return false
            }

        }).submit()
}

fun MenuItem.setActionView(context: Context, resId: Int) {
    actionView = Telereso.getActionView(context, resId)
}

fun ImageView.setRemoteImageResource(resId: Int) {
    val key = getKeyName(resId)
    val url = Telereso.getRemoteImage(context, key)
    val default = AppCompatResources.getDrawable(context, resId)
    if (url.isNullOrBlank())
        setImageDrawable(default)
    else
        Glide.with(this).load(url).addListener(object : RequestListener<Drawable> {
            override fun onLoadFailed(e: GlideException?, model: Any?, target: Target<Drawable>?, isFirstResource: Boolean): Boolean {
                Log.e(TAG_DRAWABLES, "failed to load key:$key with url:$url")
                return false
            }

            override fun onResourceReady(resource: Drawable?, model: Any?, target: Target<Drawable>?, dataSource: DataSource?, isFirstResource: Boolean): Boolean {
                return false
            }

        }).placeholder(default).into(this)
}

fun Context.getStringKey(@StringRes id: Int): String {
    return resources.getResourceEntryName(id)
}

fun Context.getKeyName(@IdRes id: Int): String {
    return resources.getResourceEntryName(id)
}

fun Context.getLocal(): String {
    return Telereso.getLocal(this)
}

fun Context.getRemoteString(@StringRes id: Int): String {
    val key = getStringKey(id)
    val default = getString(id)
    return Telereso.getRemoteStringOrDefault(getLocal(), key, default)
}

fun Context.getRemoteString(@StringRes id: Int, vararg formatArgs: Any?): String {
    val key = getStringKey(id)
    val default = getString(id)
    return Telereso.getRemoteStringOrDefaultFormat(getLocal(), key, default, *formatArgs)
}

fun Context.getDpiKey(): String {
    return resources.getDpiKey()
}

fun Resources.getDpiKey(): String {
    return when (displayMetrics.densityDpi) {
        DENSITY_LOW -> "ldpi"
        DENSITY_MEDIUM -> "mdpi"
        DENSITY_TV, DENSITY_HIGH -> "hdpi"
        DENSITY_260, DENSITY_280, DENSITY_300, DENSITY_XHIGH -> "xhdpi"
        DENSITY_340, DENSITY_360, DENSITY_400, DENSITY_420, DENSITY_440, DENSITY_XXHIGH -> "xxhdpi"
        DENSITY_560, DENSITY_XXXHIGH -> "xxxhdpi"
        else -> "xhdpi"
    }
}



/**
 * Called internally to fill the given menu. If a sub menu is seen, it will
 * call this recursively.
 */
@Throws(XmlPullParserException::class, IOException::class)
fun parseMenu(
        context: Context,
        parser: XmlPullParser,
        attrs: AttributeSet,
        menu: Menu
) {
    var eventType = parser.eventType
    var tagName: String
    var lookingForEndOfUnknownTag = false
    var unknownTagName: String? = null
//    var groupId = 0
//    var groupCategory = 0
//    var groupOrder = 0
//    var groupCheckable = 0
//    var groupVisible = false
//    var groupEnabled = false

    // This loop will skip to the menu start tag
    do {
        if (eventType == XmlPullParser.START_TAG) {
            tagName = parser.name
            if (tagName == "menu") {
                // Go to next tag
                eventType = parser.next()
                break
            }
            throw RuntimeException("Expecting menu, got $tagName")
        }
        eventType = parser.next()
    } while (eventType != XmlPullParser.END_DOCUMENT)
    var reachedEndOfMenu = false
    while (!reachedEndOfMenu) {
        when (eventType) {
            XmlPullParser.START_TAG -> {
                if (lookingForEndOfUnknownTag) {
                    break
                }
                tagName = parser.name
                when (tagName) {
                    "group" -> {
//                        val a: TypedArray = context.obtainStyledAttributes(attrs, R.styleable.MenuGroup)
//                        groupId = a.getResourceId(R.styleable.MenuGroup_android_id, 0)
//                        groupCategory = a.getInt(
//                                R.styleable.MenuGroup_android_menuCategory, 0)
//                        groupOrder = a.getInt(R.styleable.MenuGroup_android_orderInCategory, 0)
//                        groupCheckable = a.getInt(
//                                R.styleable.MenuGroup_android_checkableBehavior, 0)
//                        groupVisible = a.getBoolean(R.styleable.MenuGroup_android_visible, false)
//                        groupEnabled = a.getBoolean(R.styleable.MenuGroup_android_enabled, false)
//                        a.recycle()
                    }
                    "item" -> {
                        //menuState.readItem(attrs)
                        context.theme.obtainStyledAttributes(attrs, R.styleable.MenuItem, 0, 0)
                                .apply {
                                    val id = getResourceId(R.styleable.MenuItem_android_id, 0)
                                    if (id != 0)
                                        menu.findItem(id)?.apply {
                                            title = context.getRemoteString(getResourceId(R.styleable.MenuItem_android_title, 0))
                                            setRemoteDrawable(context, getResourceId(R.styleable.MenuItem_android_icon, 0))
                                        }
                                }
                    }
                    "menu" -> {
                        // A menu start tag denotes a submenu for an item
                        //val subMenu = menuState.addSubMenuItem()

                        // Parse the submenu into returned SubMenu
                        //parseMenu(parser, attrs, subMenu)
                    }
                    else -> {
                        lookingForEndOfUnknownTag = true
                        unknownTagName = tagName
                    }
                }
            }
            XmlPullParser.END_TAG -> {
                tagName = parser.name
                if (lookingForEndOfUnknownTag && tagName == unknownTagName) {
                    lookingForEndOfUnknownTag = false
                    unknownTagName = null
                } else if (tagName == "group") {
                    //menuState.resetGroup()
                } else if (tagName == "item") {
                    // Add the item if it hasn't been added (if the item was
                    // a submenu, it would have been added already)
//                        if (!menuState.hasAddedItem()) {
//                            if (menuState.itemActionProvider != null &&
//                                    menuState.itemActionProvider.hasSubMenu()) {
//                                menuState.addSubMenuItem()
//                            } else {
//                                menuState.addItem()
//                            }
//                        }
                } else if (tagName == "menu") {
                    reachedEndOfMenu = true
                }
            }
            XmlPullParser.END_DOCUMENT -> throw RuntimeException("Unexpected end of document")
        }
        eventType = parser.next()
    }
}

