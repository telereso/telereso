package io.telereso.android.db

import android.content.Context
import androidx.annotation.Keep
import androidx.room.*
import io.telereso.android.resrouce.Resource
import io.telereso.android.resrouce.ResourceDao

@Database(entities = [Resource::class, Info::class], version = 1)
@TypeConverters(Converters::class)
internal abstract class TeleresoDatabase : RoomDatabase() {
    abstract fun resourceDao(): ResourceDao
    abstract fun infoDao(): InfoDao

    companion object {
        @Volatile
        private var instance: TeleresoDatabase? = null

        fun getInstance(context: Context): TeleresoDatabase {
            return instance ?: synchronized(this) {
                instance ?: Room.databaseBuilder(
                    context.applicationContext,
                    TeleresoDatabase::class.java, "telereso-db"
                ).build().also { instance = it }
            }
        }
    }

}

@Entity
@Keep
data class Info(@PrimaryKey val key: String, val value: String?)

@Dao
interface InfoDao {
    companion object {
        private const val INFO_LAST_FETCHED = "lastFetched"
        private const val INFO_CURRENT_RESOURCES_HASH = "currentResourcesHash"
    }

    @Query("SELECT * FROM info where `key` = :key")
    suspend fun get(key: String): Info?

    @Query("SELECT * FROM info")
    suspend fun getAll(): List<Info>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(vararg resource: Info)

    suspend fun setLastFetched(milliSeconds: Long) {
        insertAll(Info(INFO_LAST_FETCHED, milliSeconds.toString()))
    }

    suspend fun getLastFetched(): Long {
        return get(INFO_LAST_FETCHED)?.value?.toLong() ?: 0L
    }

    suspend fun setCurrentResourcesHash(hash: String) {
        insertAll(Info(INFO_CURRENT_RESOURCES_HASH, hash))
    }

    suspend fun getCurrentResourcesHash(): String {
        return get(INFO_CURRENT_RESOURCES_HASH)?.value ?: ""
    }
}