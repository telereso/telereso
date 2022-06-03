package io.telereso.android.resrouce

import android.content.Context
import android.net.Uri
import com.google.firebase.ktx.Firebase
import com.google.firebase.remoteconfig.ktx.remoteConfig
import io.telereso.android.Telereso
import io.telereso.android.db.Converters
import io.telereso.android.db.InfoDao
import io.telereso.android.db.TeleresoDatabase
import io.telereso.android.md5
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.withContext
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import org.json.JSONObject
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class ResourceRepository(
    context: Context,
    var interceptors: List<Interceptor> = emptyList(),
) {
    private val dao: ResourceDao
    private val dbInfoDao: InfoDao

    private var resourceMapJson = JSONObject()

    init {
        if (retrofit == null) {
            val builder = OkHttpClient.Builder()
            interceptors.forEach {
                builder.addInterceptor(it)
            }

            retrofit = Retrofit.Builder().baseUrl("https://www.google.com/")
                .client(builder.build())
                .addConverterFactory(GsonConverterFactory.create())
                .build()

            resourceService = retrofit!!.create(ResourceService::class.java)
        }
        dao = TeleresoDatabase.getInstance(context).resourceDao()
        dbInfoDao = TeleresoDatabase.getInstance(context).infoDao()
    }

    suspend fun fetchEndpoints(
        endPoints: HashMap<String, Map<String, String>?>,
        isRealtimeChange: Boolean = false
    ): Boolean {
        if (endPoints.isEmpty()) return false
        return withContext(Dispatchers.IO) {
            val count = dao.getCount()
            val (lastFetched, shouldFetch) = shouldFetch()
            if (count > 0 && !shouldFetch) {
                Telereso.log("No need to fetch cache, last fetched $lastFetched , keys count: $count")
                return@withContext false
            }
            Telereso.log("Need to fetch and update cache, last fetched $lastFetched")
            val res = endPoints.map {
                async {
                    var url = it.key
                    if (isRealtimeChange) {
                        url = Uri.parse(url).buildUpon().appendQueryParameter(
                            "t",
                            "${System.currentTimeMillis() / 1000}"
                        ).build().toString()
                    }
                    resourceService.fetchEndpoint(url, it.value ?: emptyMap())
                }
            }
            val responses = res.awaitAll()
            val mapList = hashMapOf<String, Resource>()
            val allMap = hashMapOf<String, Map<String, String>>()
            responses.forEach { map ->
                map.forEach {
                    val prevValues = mapList[it.key] ?: Resource(it.key, mapOf())
                    val mergedMap = it.value + prevValues.value
                    allMap[it.key] = mergedMap
                    mapList[it.key] = Resource(it.key, mergedMap)
                }
            }

            Telereso.log("fetched ${mapList.values.size} keys")
            val hash = Converters.toString(allMap).md5()
            if (dbInfoDao.getCurrentResourcesHash() != hash) {
                dao.cleanThenInsert(
                    dbInfoDao,
                    hash,
                    *mapList.values.toTypedArray()
                )
                return@withContext true
            }
            return@withContext false
        }
    }

    private suspend fun shouldFetch(): Pair<Long, Boolean> {
        val interval = Firebase.remoteConfig.info.configSettings.minimumFetchIntervalInSeconds
        val lastFetched = dbInfoDao.getLastFetched()
        return Pair(
            lastFetched,
            (System.currentTimeMillis() - lastFetched) / 1000 >= interval
        )
    }

    suspend fun loadResources() {
        withContext(Dispatchers.IO) {
            val resourceMap = dao.getAll().associate {
                it.key to it.value
            }
            resourceMapJson = Converters.toJson(resourceMap)
        }
    }

    fun getString(key: String): String {
        return resourceMapJson.optString(key)
    }

    fun getKeysByPrefix(prefix: String): Set<String> {
        val set = hashSetOf<String>()
        resourceMapJson.keys().forEach {
            if (it.startsWith(prefix))
                set.add(it)
        }
        return set
    }

    companion object {
        private var retrofit: Retrofit? = null
        private lateinit var resourceService: ResourceService

    }
}