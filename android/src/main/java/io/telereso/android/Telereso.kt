package io.telereso.android

import android.content.Context
import android.util.Log
import androidx.annotation.StringRes
import com.google.firebase.ktx.Firebase
import com.google.firebase.messaging.FirebaseMessaging
import com.google.firebase.messaging.RemoteMessage
import com.google.firebase.messaging.ktx.messaging
import com.google.firebase.remoteconfig.FirebaseRemoteConfig
import com.google.firebase.remoteconfig.ktx.remoteConfig
import com.google.firebase.remoteconfig.ktx.remoteConfigSettings
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import org.json.JSONObject

const val TAG = "Telereso"

object Telereso {
    private val listenersList = hashSetOf<RemoteChanges>()
    private val stringsMap = HashMap<String, JSONObject>()

    @JvmStatic
    @JvmOverloads
    fun init(
        remoteChanges: RemoteChanges? = null,
        finishSetup: (() -> Unit?)? = null
    ) {
        Log.d(TAG, "initializing...")
        if (BuildConfig.DEBUG)
            Firebase.remoteConfig.setConfigSettingsAsync(remoteConfigSettings {
                minimumFetchIntervalInSeconds = 0
            })

        remoteChanges?.let { addChangeListener(it) }
        initMaps()
        fetchResource(finishSetup)
        Log.d(TAG, "Telereso initialized")
    }

    private fun initMaps() {
        var en = Firebase.remoteConfig.getString("strings_en")
        if (en.isBlank())
            en = "{}"
        stringsMap["strings_en"] = JSONObject(en)
    }

    private fun fetchResource(finishSetup: (() -> Unit?)? = null) {
        Firebase.remoteConfig.fetchAndActivate().addOnSuccessListener {
            GlobalScope.launch(context = Dispatchers.Default) {
                if (it) {
                    initMaps()
                    HashSet(listenersList).forEach { l -> l.onRemoteUpdate() }
                }
                finishSetup?.invoke()
            }
        }
    }

    @JvmStatic
    fun subscriptToChanges() {
        Log.d(TAG, "subscribe to changes")
        Firebase.messaging.subscribeToTopic("TELERESO_PUSH_RC")
    }

    @JvmStatic
    fun handleRemoteMessage(remoteMessage: RemoteMessage): Boolean {
        return if (remoteMessage.data.containsKey("TELERESO_CONFIG_STATE")) {
            Log.d(TAG, "remote changed, refreshing...")
            fetchResource()
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
    fun getRemoteStringOrDefault(key: String, default: String? = null): String {
        val value = stringsMap["strings_en"]?.optString(key, default ?: "") ?: ""
        Log.d(TAG, "key:$key default:$default value:$value")
        if (value.isBlank()) {
            GlobalScope.launch(Dispatchers.Default) {
                HashSet(listenersList).forEach { l -> l.onResourceNotFound(key) }
            }
        }
        return value
    }

    @JvmStatic
    fun getRemoteStringOrDefault(
        key: String,
        default: String? = null,
        vararg formatArgs: Any?
    ): String {
        Log.d(TAG, "key $key value $default")
        var value = stringsMap["strings_en"]?.optString(key, default ?: "") ?: ""
        if (value.isBlank()) {
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
        return getRemoteStringOrDefault(key, default)
    }
}
