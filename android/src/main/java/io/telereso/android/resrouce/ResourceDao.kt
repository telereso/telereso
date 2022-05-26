package io.telereso.android.resrouce

import androidx.room.*
import io.telereso.android.db.InfoDao

@Dao
interface ResourceDao {
    @Query("SELECT * FROM resource")
    suspend fun getAll(): List<Resource>

    @Query("SELECT COUNT(*) FROM resource")
    suspend fun getCount(): Int

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(vararg resource: Resource)

    @Query("DELETE FROM resource")
    suspend fun cleanTable()

    @Transaction
    suspend fun cleanThenInsert(
        dbInfoDao: InfoDao,
        newDataHash: String,
        vararg resource: Resource
    ) {
        cleanTable()
        insertAll(*resource)
        dbInfoDao.setLastFetched(System.currentTimeMillis())
        dbInfoDao.setCurrentResourcesHash(newDataHash)
    }
}