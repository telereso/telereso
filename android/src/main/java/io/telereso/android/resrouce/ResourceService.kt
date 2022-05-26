package io.telereso.android.resrouce

import retrofit2.http.GET
import retrofit2.http.HeaderMap
import retrofit2.http.Url

interface ResourceService {
        @GET
        suspend fun fetchEndpoint(
            @Url url: String,
            @HeaderMap headers: Map<String, String> = mapOf()
        ): Map<String, Map<String, String>>
    }