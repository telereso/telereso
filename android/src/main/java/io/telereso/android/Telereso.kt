package io.telereso.android

import android.content.Context
import android.content.res.Resources
import android.content.res.XmlResourceParser
import android.util.Log
import android.util.Xml
import android.view.*
import android.widget.ImageView
import android.widget.LinearLayout
import androidx.annotation.StringRes
import com.bumptech.glide.Glide
import com.google.firebase.ktx.Firebase
import com.google.firebase.messaging.RemoteMessage
import com.google.firebase.messaging.ktx.messaging
import com.google.firebase.remoteconfig.ktx.remoteConfig
import com.google.firebase.remoteconfig.ktx.remoteConfigSettings
import kotlinx.coroutines.*
import org.json.JSONObject
import org.xmlpull.v1.XmlPullParserException
import java.io.IOException
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

internal const val TAG = "Telereso"
internal const val TAG_STRINGS = "${TAG}_strings"
internal const val TAG_DRAWABLES = "${TAG}_drawable"
private const val STRINGS = "strings"
private const val DRAWABLE = "drawable"

object Telereso {
    private val listenersList = hashSetOf<RemoteChanges>()
    private val stringsMap = HashMap<String, JSONObject>()
    private var drawableMap = HashMap<String, JSONObject>()
    private val densityList = listOf("ldpi", "mdpi", "hdpi", "xhdpi", "xxhdpi", "xxxhdpi")

    @JvmStatic
    @JvmOverloads
    fun init(
            context: Context,
            finishSetup: () -> Unit = {}
    ) {
        val remoteChanges: RemoteChanges? = null
        val listenToRemoteChanges = true
        Log.d(TAG, "initializing...")
        if (listenToRemoteChanges)
            Firebase.remoteConfig.setConfigSettingsAsync(remoteConfigSettings {
                minimumFetchIntervalInSeconds = 0
            })
        GlobalScope.launch {
            remoteChanges?.let { addChangeListener(it) }

            val shouldUpdate = async { fetchResource() }

            initMaps(context)

            Log.d(TAG, "initialized!")

            if (shouldUpdate.await()) {
                Log.d(TAG, "fetched new data")
                initMaps(context)
            }

            finishSetup()
        }

    }

    suspend fun suspendInit(context: Context) {
        val remoteChanges: RemoteChanges? = null
        val listenToRemoteChanges = true
        Log.d(TAG, "initializing...")
        if (listenToRemoteChanges)
            Firebase.remoteConfig.setConfigSettingsAsync(remoteConfigSettings {
                minimumFetchIntervalInSeconds = 0
            })
        remoteChanges?.let { addChangeListener(it) }

        fetchResource()

        initMaps(context)

        Log.d(TAG, "initialized!")

    }

    private suspend fun initMaps(context: Context) {
        withContext(context = Dispatchers.IO) {

            //  strings
            val defaultId = STRINGS
            var default = Firebase.remoteConfig.getString(defaultId)
            if (default.isBlank()) {
                default = "{}"
                Log.e(TAG, "your default local $defaultId was not found in remote config")
            } else {
                Log.d(TAG, "default local $defaultId was setup")
            }
            stringsMap[defaultId] = JSONObject(default)

            val deviceLocal = getLocal(context)
            val deviceId = getStringKey(deviceLocal)
            var local = Firebase.remoteConfig.getString(deviceId)
            if (local.isBlank()) {
                local = "{}"
                Log.e(TAG, "the device local $deviceId was not found in remote config")
            } else {
                Log.d(TAG, "device local $deviceId was setup")
            }
            stringsMap[deviceId] = JSONObject(local)


            //drawables
            var defaultDrawables = Firebase.remoteConfig.getString(DRAWABLE)
            if (defaultDrawables.isBlank()) {
                defaultDrawables = "{}"
            }
            drawableMap[DRAWABLE] = JSONObject(defaultDrawables)

            drawableMap[DRAWABLE]?.keys()?.forEach {
                try {
                    Glide.with(context).load(it).timeout(200).submit().get()
                } catch (t: Throwable) {
                }
            }


            getSupportedDensities(context).forEach { deviceDensity ->
                val deviceDrawableId = getDrawableKey(deviceDensity)
                var deviceDrawables = Firebase.remoteConfig.getString(deviceDrawableId)
                if (deviceDrawables.isBlank()) {
                    deviceDrawables = "{}"
                }
                drawableMap[deviceDrawableId] = JSONObject(deviceDrawables)

                drawableMap[deviceDrawableId]?.keys()?.forEach {
                    try {
                        Glide.with(context).load(it).timeout(1000).submit()
                    } catch (t: Throwable) {
                    }
                }
            }

        }
    }

    private suspend fun fetchResource(): Boolean {
        return suspendCoroutine { coroutine ->
            Firebase.remoteConfig.fetchAndActivate().addOnCompleteListener { res -> coroutine.resume(if (res.isSuccessful) res.result else false) }
        }
    }

    @JvmStatic
    fun subscriptToChanges() {
        Log.d(TAG, "subscribe to changes")
        Firebase.messaging.subscribeToTopic("TELERESO_PUSH_RC")
    }

    @JvmStatic
    fun handleRemoteMessage(context: Context, remoteMessage: RemoteMessage): Boolean {
        return if (remoteMessage.data.containsKey("TELERESO_CONFIG_STATE")) {
            Log.d(TAG, "remote changed, refreshing...")
            GlobalScope.launch {
                if (fetchResource()) {
                    initMaps(context)
                    HashSet(listenersList).forEach { l -> l.onRemoteUpdate() }
                }
            }
            true
        } else
            false
    }


    fun addChangeListener(listener: RemoteChanges) {
        listenersList.add(listener)
    }

    fun removeChangeListener(listener: RemoteChanges) {
        listenersList.remove(listener)
    }

    @JvmStatic
    fun getRemoteStringOrDefault(
            local: String,
            key: String,
            default: String? = null
    ): String {
        val value = getStringValue(local, key, default)
        Log.d(TAG_STRINGS, "local:$local key:$key default:$default value:$value")
        if (value.isBlank()) {
            Log.e(TAG, "$key was empty in ${getStringKey(local)} and $STRINGS and local strings")
            GlobalScope.launch(Dispatchers.Default) {
                HashSet(listenersList).forEach { l -> l.onResourceNotFound(key) }
            }
        }
        return value
    }

    @JvmStatic
    fun getRemoteStringOrDefaultFormat(
            local: String,
            key: String,
            default: String? = null,
            vararg formatArgs: Any?
    ): String {
        var value = getStringValue(local, key, default)
        Log.d(TAG_STRINGS, "local:$local key:$key default:$default value:$value")
        if (value.isBlank()) {
            Log.e(TAG, "$key was empty in ${getStringKey(local)} and $STRINGS and local strings")
            GlobalScope.launch(Dispatchers.Default) {
                HashSet(listenersList).forEach { l -> l.onResourceNotFound(key) }
            }
        } else {
            value = value.format(formatArgs)
        }
        return value
    }

    @JvmStatic
    fun getRemoteString(context: Context, @StringRes id: Int): String {
        val key = context.resources.getResourceEntryName(id)
        val default = context.getString(id)
        return getRemoteStringOrDefault(getLocal(context), key, default)
    }

    private fun getStringValue(local: String, key: String, default: String?): String {
        val defaultId = STRINGS
        val localId = getStringKey(local)
        var value = stringsMap[localId]?.optString(key, "") ?: ""
        if (value.isBlank()) {
            Log.w(TAG_STRINGS, "$key was not found in remote $localId")
            value = stringsMap[defaultId]?.optString(key, "") ?: ""
            if (value.isBlank()) {
                Log.w(TAG_STRINGS, "$key was not found in remote $defaultId")
                value = default ?: ""
            }
        }
        return value
    }

    internal fun getLocal(context: Context): String {
        return if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            context.resources.configuration.locales[0].language.toString()
        } else {
            context.resources.configuration.locale.language.toString()
        }
    }

    internal fun getLocal(resources: Resources): String {
        return if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            resources.configuration.locales[0].language.toString()
        } else {
            resources.configuration.locale.language.toString()
        }
    }

    @JvmStatic
    fun setRemoteImageResource(imageView: ImageView, resId: Int) {
        imageView.setRemoteImageResource(resId)
    }

    fun getRemoteImage(context: Context, key: String): String? {
        var url: String? = null
        getSupportedDensities(context).forEach {
            val deviceDrawableId = getDrawableKey(it)
            url = drawableMap[deviceDrawableId]?.optString(key)
            if (!url.isNullOrBlank())
                return url
        }
        if (url.isNullOrBlank()) {
            url = drawableMap[DRAWABLE]?.optString(key)
        }
        if (url.isNullOrBlank())
            Log.w(TAG_DRAWABLES, "drawable $key was not found in remote drawable")
        return url
    }

    private fun getStringKey(id: String): String {
        return "${STRINGS}_$id"
    }

    private fun getDrawableKey(id: String): String {
        return "${DRAWABLE}_$id"

    }

    @JvmStatic
    fun onCreateOptionsMenu(context: Context, menuInflater: MenuInflater, menuId: Int, menu: Menu) {
        menuInflater.inflate(menuId, menu)
        var parser: XmlResourceParser? = null
        try {
            parser = context.resources.getLayout(menuId)
            val attrs = Xml.asAttributeSet(parser)
            parseMenu(context, parser, attrs, menu)
        } catch (e: XmlPullParserException) {
            throw  InflateException("Error inflating menu XML", e)
        } catch (e: IOException) {
            throw  InflateException("Error inflating menu XML", e)
        } finally {
            parser?.close()
        }
    }

    @JvmStatic
    fun setActionView(context: Context, menuItem: MenuItem, resId: Int) {
        menuItem.actionView = getActionView(context, resId)
    }

    internal fun getActionView(context: Context, resId: Int): View {
        return LayoutInflater.from(context).inflate(resId, LinearLayout(context), false)
    }

    private fun getSupportedDensities(context: Context): List<String> {
        val supportedDensityList = densityList.takeWhile { it != context.getDpiKey() }.toMutableList()
        supportedDensityList.add(context.getDpiKey())
        return supportedDensityList.reversed()
    }

}
