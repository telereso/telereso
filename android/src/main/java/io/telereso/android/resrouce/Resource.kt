package io.telereso.android.resrouce

import androidx.annotation.Keep
import androidx.room.Entity
import androidx.room.PrimaryKey


@Entity
@Keep
data class Resource(
    @PrimaryKey val key: String,
    val value: Map<String, String>
)