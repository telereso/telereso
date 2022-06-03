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
import io.telereso.android.db.merge
import io.telereso.android.resrouce.ResourceRepository
import kotlinx.coroutines.*
import okhttp3.Interceptor
import org.json.JSONObject
import org.xmlpull.v1.XmlPullParserException
import java.io.IOException
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
    private var customEndpoints = HashMap<String, Map<String,String>?>()
    private var interceptors = arrayListOf<Interceptor>()

    private var resourceRepository: ResourceRepository? = null

    @JvmStatic
    fun getInstance() = this

    @JvmStatic
    @JvmOverloads
    fun init(
        context: Context,
        suspended: Boolean = false,
        finishSetup: () -> Unit = {}
    ): Telereso {
        val exceptionHandler = CoroutineExceptionHandler { _, exception ->
            onException(Exception(exception))
        }
        GlobalScope.launch(Dispatchers.IO + exceptionHandler) {
            log("Initializing...")

            resourceRepository = ResourceRepository(context, interceptors)

            if (isRealTimeChangesEnabled || remoteConfigSettings != null)
                Firebase.remoteConfig.setConfigSettingsAsync(remoteConfigSettings
                    ?: remoteConfigSettings {
                        minimumFetchIntervalInSeconds = 0
                    })


            val shouldUpdate = async { fetchResource() }

            if (suspended) shouldUpdate.await()

            initMaps(context)

            log("Initialized!")

            if (!suspended && shouldUpdate.await()) {
                initMaps(context)
            }

            finishSetup()
        }
        return this
    }

    suspend fun init(context: Context): Telereso {
        return suspendCoroutine { coroutine ->
            init(context, true) {
                coroutine.resume(this)
            }
        }
    }

    fun reset() {
        currentLocal = null
    }

    fun addCustomEndpoint(url: String, headers: Map<String, String>? = null): Telereso {
        customEndpoints[url] = headers
        return this
    }

    fun addInterceptors(vararg interceptors: Interceptor){
        this.interceptors.addAll(interceptors)
    }

    fun addInterceptor(interceptor: Interceptor){
        this.interceptors.add(interceptor)
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
            if (isRealTimeChangesEnabled) {
                log("remote updated, refreshing...")
                val exceptionHandler = CoroutineExceptionHandler { _, exception ->
                    onException(Exception(exception))
                }
                GlobalScope.launch(Dispatchers.IO + exceptionHandler) {
                    if (fetchResource(true)) {
                        initMaps(context)
                        onRemoteUpdate()
                    }
                }
            } else {
                log("remote updated")
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
            value = value.format(formatArgs)
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

    private fun initMaps(context: Context) {
        log("initMaps")

        val fireBaseRemote = object : Remote {
            override fun getName(): String {
                return "Firebase"
            }

            override fun getString(key: String): String {
                return Firebase.remoteConfig.getString(key)
            }

            override fun getKeysByPrefix(prefix: String): Set<String> {
                return Firebase.remoteConfig.getKeysByPrefix(prefix)
            }

        }

        val customRemote = object : Remote {
            override fun getName(): String {
                return "Custom"
            }

            override fun getString(key: String): String {
                return resourceRepository?.getString(key) ?: ""
            }

            override fun getKeysByPrefix(prefix: String): Set<String> {
                return resourceRepository?.getKeysByPrefix(prefix) ?: emptySet()
            }

        }

        if (customEndpoints.isNotEmpty()) {
            initStrings(context, customRemote)
            initDrawables(context, customRemote)
        }


        initStrings(context, fireBaseRemote)
        initDrawables(context, fireBaseRemote)
    }

    private fun initStrings(context: Context, remote: Remote) {
        val defaultId = STRINGS
        var default = remote.getString(defaultId)
        if (default.isBlank()) {
            default = "{}"
            log(
                "Your default local $defaultId was not found in ${remote.getName()} remote config",
                true
            )
        } else {
            log("Default local $defaultId was setup")
        }
        stringsMap[defaultId] = stringsMap[defaultId].merge(JSONObject(default))

        val deviceLocal =
            if (context is Application) currentLocal ?: getLocal(context) else getLocal(context)
        currentLocal = deviceLocal
        val local = getRemoteLocal(deviceLocal, remote)

        val deviceLocalKey = getStringKey(deviceLocal)
        stringsMap[deviceLocalKey] =
            stringsMap[deviceLocalKey].merge(JSONObject(local))
    }

    private fun initDrawables(context: Context, remote: Remote) {
        //drawables
        var defaultDrawables = remote.getString(DRAWABLES)
        if (defaultDrawables.isBlank()) {
            defaultDrawables = "{}"
        }
        drawableMap[DRAWABLES] = drawableMap[DRAWABLES].merge(JSONObject(defaultDrawables))

        drawableMap[DRAWABLES]?.apply {
            keys().forEach {
                cacheImage(context, optString(it))
            }
        }


        supportedSizes = getSupportedSizes(context)

        supportedSizes.forEach { deviceDensity ->
            val deviceDrawableId = getDrawableKey(deviceDensity)
            var deviceDrawables = remote.getString(deviceDrawableId)
            if (deviceDrawables.isBlank()) {
                deviceDrawables = "{}"
            }
            drawableMap[deviceDrawableId] =
                drawableMap[deviceDrawableId].merge(JSONObject(deviceDrawables))

            drawableMap[deviceDrawableId]?.apply {
                keys().forEach {
                    cacheImage(context, optString(it))
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

    private fun getRemoteLocal(deviceLocal: String, remote: Remote): String {
        var local = remote.getString(getStringKey(deviceLocal))
        if (local.isBlank()) {
            val baseLocal = deviceLocal.split("_")[0]
            log("The app local $deviceLocal was not found in ${remote.getName()} remote config will try $baseLocal")
            val key =
                remote.getKeysByPrefix(getStringKey(baseLocal)).firstOrNull()
            if (key == null) {
                log("$baseLocal was not found as well")
            } else {
                if (key.contains("off"))
                    log("$baseLocal was found but it was turned off, remove _off suffix to enable it")
                else
                    local = remote.getString(key)
            }

        }
        if (local.isBlank()) {
            local = "{}"
            log(
                "The app local $deviceLocal was not found in ${remote.getName()} remote config",
                true
            )
        } else {
            log("device local $deviceLocal was setup")
        }
        return local
    }

    private suspend fun fetchResource(isRealtimeChange: Boolean = false): Boolean {
        val updated = withTimeoutOrNull(timeout) {
            return@withTimeoutOrNull withContext(Dispatchers.IO) {
                val customUpdatedRes = async {
                    return@async resourceRepository?.fetchEndpoints(
                        customEndpoints,
                        isRealtimeChange
                    ) ?: false
                }
                val firebaseUpdatedRes = async {
                    return@async fetchFireBase()
                }
                val customUpdated = customUpdatedRes.await()
                val firebaseUpdated = firebaseUpdatedRes.await()
                log("fetched resources: customUpdated $customUpdated - firebaseUpdated $firebaseUpdated")
                return@withContext customUpdated || firebaseUpdated
            }
        }

        if (customEndpoints.isNotEmpty())
            resourceRepository?.loadResources()

        when (updated) {
            null -> log("Failed to fetch due to timeout, check network connectivity")
            true -> log("Fetched new data")
            else -> {}
        }
        return updated ?: false
    }

    private suspend fun fetchFireBase(): Boolean {
        return suspendCoroutine { coroutine ->
            Firebase.remoteConfig.fetchAndActivate()
                .addOnCompleteListener { res -> coroutine.resume(if (res.isSuccessful) res.result else false) }
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

    internal fun log(log: String, isWarning: Boolean = false) {
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
