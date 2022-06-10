package io.telereso.android

import android.app.Application
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
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.google.firebase.ktx.Firebase
import com.google.firebase.messaging.RemoteMessage
import com.google.firebase.messaging.ktx.messaging
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings
import com.google.firebase.remoteconfig.ktx.remoteConfig
import com.google.firebase.remoteconfig.ktx.remoteConfigSettings
import kotlinx.coroutines.*
import org.json.JSONObject
import org.xmlpull.v1.XmlPullParserException
import java.io.IOException
import kotlin.collections.HashMap
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

internal const val TAG = "Telereso"
internal const val TAG_STRINGS = "${TAG}_strings"
internal const val TAG_DRAWABLES = "${TAG}_drawables"
private const val STRINGS = "strings"
private const val DRAWABLES = "drawables"
private const val TIMEOUT = 8000L

object Telereso {
    private var timeout = TIMEOUT
    private var isLogEnabled = true
    private var isStringLogEnabled = false
    private var isDrawableLogEnabled = false
    private var isRealTimeChangesEnabled = false
    private var remoteConfigSettings: FirebaseRemoteConfigSettings? = null

    private val listenersList = hashSetOf<RemoteChanges>()
    private val stringsMap = HashMap<String, JSONObject>()
    private var currentLocal: String? = null
    private var drawableMap = HashMap<String, JSONObject>()
    private val densityList = listOf("ldpi", "mdpi", "hdpi", "xhdpi", "xxhdpi", "xxxhdpi")
    private val sizesList = listOf("1x", "2x", "3x")
    private var supportedSizes = listOf("1x")

    @JvmStatic
    fun getInstance() = this

    @JvmStatic
    @JvmOverloads
    fun init(
        context: Context,
        finishSetup: () -> Unit = {}
    ): Telereso {
        GlobalScope.launch {
            log("Initializing...")
            if (isRealTimeChangesEnabled || remoteConfigSettings != null)
                Firebase.remoteConfig.setConfigSettingsAsync(remoteConfigSettings
                    ?: remoteConfigSettings {
                        minimumFetchIntervalInSeconds = 0
                    })

            val init = withTimeoutOrNull(timeout) {

                val shouldUpdate = async { fetchResource() }

                initMaps(context)

                log("Initialized!")

                if (shouldUpdate.await()) {
                    log("Fetched new data")
                    initMaps(context)
                }

                return@withTimeoutOrNull true
            }
            if (init == null) {
                log("Failed to initialize due to timeout, check network connectivity")
            }

            finishSetup()
        }
        return this
    }

    suspend fun suspendInit(context: Context) {
        log("Initializing...")
        if (isRealTimeChangesEnabled || remoteConfigSettings != null)
            Firebase.remoteConfig.setConfigSettingsAsync(remoteConfigSettings
                ?: remoteConfigSettings {
                    minimumFetchIntervalInSeconds = 0
                })

        val init = withTimeoutOrNull(timeout) {

            fetchResource()

            initMaps(context)

            log("Initialized!")
            return@withTimeoutOrNull true
        }

        if (init == null) {
            log("Failed to initialize due to timeout, check network connectivity")
        }
    }

    fun reset() {
        currentLocal = null
    }

    fun setRemoteConfigSettings(remoteConfigSettings: FirebaseRemoteConfigSettings): Telereso {
        this.remoteConfigSettings = remoteConfigSettings;
        return this
    }

    fun enableStringLog(): Telereso {
        isStringLogEnabled = true
        return this
    }

    fun enableDrawableLog(): Telereso {
        isDrawableLogEnabled = true
        return this
    }

    fun disableLog(): Telereso {
        isLogEnabled = false
        return this
    }

    fun setInitTimeout(long: Long): Telereso {
        timeout = long
        return this
    }

    fun enableRealTimeChanges(): Telereso {
        isRealTimeChangesEnabled = true
        GlobalScope.launch {
            subscriptToChanges()
        }
        return this
    }

    fun addRemoteChangesListener(remoteChanges: RemoteChanges): Telereso {
        addChangeListener(remoteChanges)
        return this
    }

    @JvmStatic
    fun handleRemoteMessage(context: Context, remoteMessage: RemoteMessage): Boolean {
        return if (remoteMessage.data.containsKey("TELERESO_CONFIG_STATE")) {
            log("remote changed, refreshing...")
            if (isRealTimeChangesEnabled)
                GlobalScope.launch {
                    if (fetchResource()) {
                        initMaps(context)
                        onRemoteUpdate()
                    }
                }
            true
        } else
            false
    }

    @JvmStatic
    @Synchronized
    fun addChangeListener(listener: RemoteChanges) {
        listenersList.add(listener)
    }

    @JvmStatic
    @Synchronized
    fun removeChangeListener(listener: RemoteChanges) {
        listenersList.remove(listener)
    }

    private fun onRemoteUpdate() {
        val iterator = listenersList.iterator()
        while (iterator.hasNext()) {
            iterator.next().onRemoteUpdate()
        }
    }

    private fun onResourceNotFound(key: String) {
        GlobalScope.launch(Dispatchers.Default) {
            val iterator = listenersList.iterator()
            while (iterator.hasNext()) {
                iterator.next().onResourceNotFound(key)
            }
        }
    }

    private fun onException(e: Exception) {
        GlobalScope.launch(Dispatchers.Default) {
            val iterator = listenersList.iterator()
            while (iterator.hasNext()) {
                iterator.next().onException(e)
            }
        }
    }

    @JvmStatic
    fun getRemoteStringOrDefault(
        local: String,
        key: String,
        default: String? = null
    ): String {
        logStrings("******************** $key ********************")
        val value = getStringValue(local, key, default)
        logStrings("local:$local default:$default value:$value")
        if (value.isBlank()) {
            logStrings(
                "$key was empty in ${getStringKey(local)} and $STRINGS and local strings",
                true
            )
            onResourceNotFound(key)
        }
        logStrings("*************************************************")
        return value
    }

    @JvmStatic
    fun getRemoteStringOrDefaultFormat(
            local: String,
            key: String,
            default: String? = null,
            vararg formatArgs: Any?
    ): String {
        logStrings("******************** $key ********************")
        var value = getStringValue(local, key, default)
        logStrings("local:$local default:$default value:$value")
        if (value.isBlank()) {
            logStrings(
                "$key was empty in ${getStringKey(local)} and $STRINGS and local strings",
                true
            )
            onResourceNotFound(key)
        } else {
            value = value.format(*formatArgs)
        }
        logStrings("*************************************************")
        return value
    }

    @JvmStatic
    fun getRemoteString(context: Context, @StringRes id: Int): String {
        val key = context.resources.getResourceEntryName(id)
        val default = context.getString(id)
        return getRemoteStringOrDefault(getLocal(context), key, default)
    }

    @JvmStatic
    fun getRemoteString(context: Context, @StringRes id: Int, vararg formatArgs: Any?): String {
        val key = context.resources.getResourceEntryName(id)
        val default = context.getString(id)
        return getRemoteStringOrDefaultFormat(getLocal(context), key, default, *formatArgs)
    }

    @JvmStatic
    fun setRemoteImageResource(imageView: ImageView, resId: Int) {
        imageView.setRemoteImageResource(resId)
    }

    fun getRemoteImage(context: Context, key: String): String? {
        logDrawables("******************** $key ********************")
        var url: String? = null
        var deviceDrawableId: String? = null
        run {
            supportedSizes.forEach {
                deviceDrawableId = getDrawableKey(it)
                url = drawableMap[deviceDrawableId]?.optString(key)
                if (!url.isNullOrBlank())
                    return@run
            }
        }
        if (url.isNullOrBlank()) {
            deviceDrawableId = DRAWABLES
            url = drawableMap[DRAWABLES]?.optString(key)
        }
        logDrawables("density:$deviceDrawableId remote:$url")
        logDrawables("*************************************************")
        return url
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

    private suspend fun initMaps(context: Context) {
        withContext(context = Dispatchers.Default) {

            //  strings
            val defaultId = STRINGS
            var default = Firebase.remoteConfig.getString(defaultId)
            if (default.isBlank()) {
                default = "{}"
                log("Your default local $defaultId was not found in remote config", true)
            } else {
                log("Default local $defaultId was setup")
            }
            stringsMap[defaultId] = JSONObject(default)

            val deviceLocal =
                if (context is Application) currentLocal ?: getLocal(context) else getLocal(context)
            currentLocal = deviceLocal
            val local = getRemoteLocal(deviceLocal)

            stringsMap[getStringKey(deviceLocal)] = JSONObject(local)


            //drawables
            var defaultDrawables = Firebase.remoteConfig.getString(DRAWABLES)
            if (defaultDrawables.isBlank()) {
                defaultDrawables = "{}"
            }
            drawableMap[DRAWABLES] = JSONObject(defaultDrawables)

            drawableMap[DRAWABLES]?.apply {
                keys().forEach {
                    cacheImage(context, optString(it))
                }
            }


            supportedSizes = getSupportedSizes(context)

            supportedSizes.forEach { deviceDensity ->
                val deviceDrawableId = getDrawableKey(deviceDensity)
                var deviceDrawables = Firebase.remoteConfig.getString(deviceDrawableId)
                if (deviceDrawables.isBlank()) {
                    deviceDrawables = "{}"
                }
                drawableMap[deviceDrawableId] = JSONObject(deviceDrawables)

                drawableMap[deviceDrawableId]?.apply {
                    keys().forEach {
                        cacheImage(context, optString(it))
                    }
                }
            }

        }
    }

    private fun cacheImage(context: Context, url: String?) {
        try {
            if (!url.isNullOrBlank())
                Glide.with(context).load(url)
                    .skipMemoryCache(true)
                    .diskCacheStrategy(DiskCacheStrategy.ALL)
                    .timeout(1000)
                    .submit()
        } catch (e: Exception) {
            onException(e)
        }
    }

    private fun getRemoteLocal(deviceLocal: String): String {
        var local = Firebase.remoteConfig.getString(getStringKey(deviceLocal))
        if (local.isBlank()) {
            val baseLocal = deviceLocal.split("_")[0]
            log("The app local $deviceLocal was not found in remote config will try $baseLocal")
            val key =
                Firebase.remoteConfig.getKeysByPrefix(getStringKey(baseLocal)).firstOrNull()
            if (key == null) {
                log("$baseLocal was not found as well")
            } else {
                if (key.contains("off"))
                    log("$baseLocal was found but it was turned off, remove _off suffix to enable it")
                else
                    local = Firebase.remoteConfig.getString(key)
            }

        }
        if (local.isBlank()) {
            local = "{}"
            log("The app local $deviceLocal was not found in remote config", true)
        } else {
            log("device local $deviceLocal was setup")
        }
        return local
    }

    private suspend fun fetchResource(): Boolean {
        return suspendCoroutine { coroutine ->
            Firebase.remoteConfig.fetchAndActivate().addOnCompleteListener { res -> coroutine.resume(if (res.isSuccessful) res.result else false) }
        }
    }

    private fun subscriptToChanges() {
        log("Subscribe to changes on topic TELERESO_PUSH_RC")
        Firebase.messaging.subscribeToTopic("TELERESO_PUSH_RC")
    }

    private fun getSupportedDensities(context: Context): List<String> {
        val supportedDensityList = densityList.takeWhile {
            it != context.getDpiKey()
        }.toMutableList()
        supportedDensityList.add(context.getDpiKey())
        return supportedDensityList.reversed()
    }

    private fun getSupportedSizes(context: Context): List<String> {
        val supportedSizesList = sizesList.takeWhile {
            it != context.getSizeKey()
        }.toMutableList()
        supportedSizesList.add(context.getSizeKey())
        return supportedSizesList.reversed()
    }

    private fun getStringKey(id: String): String {
        return "${STRINGS}_$id"
    }

    private fun getDrawableKey(id: String): String {
        return "${DRAWABLES}_$id"
    }

    private fun getStringValue(local: String, key: String, default: String?): String {
        val defaultId = STRINGS
        val localId = getStringKey(local)
        var value = stringsMap[localId]?.optString(key, "") ?: ""
        if (value.isBlank()) {
            logStrings("$key was not found in remote $localId", true)
            value = stringsMap[defaultId]?.optString(key, "") ?: ""
            if (value.isBlank()) {
                logStrings("$key was not found in remote $defaultId", true)
                value = default ?: ""
            } else {
                logStrings("$key was found in remote $defaultId")
            }
        }
        return value
    }

    internal fun getLocal(context: Context): String {
        return if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            context.resources.configuration.locales[0].toString().lowercase()
        } else {
            context.resources.configuration.locale.toString().lowercase()
        }
    }

    internal fun getLocal(resources: Resources): String {
        return if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            resources.configuration.locales[0].toString().lowercase()
        } else {
            resources.configuration.locale.toString().lowercase()
        }
    }

    internal fun isRealTimeChangesEnabled(): Boolean {
        return isRealTimeChangesEnabled
    }

    private fun log(log: String, isWarning: Boolean = false) {
        if (isLogEnabled)
            if (isWarning) Log.w(TAG, log) else Log.d(TAG, log)
    }

    private fun logStrings(log: String, isWarning: Boolean = false) {
        if (isStringLogEnabled)
            if (isWarning) Log.w(TAG_STRINGS, log) else Log.d(TAG_STRINGS, log)
    }

    private fun logDrawables(log: String, isWarning: Boolean = false) {
        if (isDrawableLogEnabled)
            if (isWarning) Log.d(TAG_DRAWABLES, log) else Log.d(TAG_DRAWABLES, log)

    }

}
