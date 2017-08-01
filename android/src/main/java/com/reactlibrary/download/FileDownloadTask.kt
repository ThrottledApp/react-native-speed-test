package com.reactlibrary.download

import okhttp3.OkHttpClient
import okhttp3.Request

/**
 * Created by mbpeele on 7/31/17.
 */
class FileDownloadTask(private val progressListener: ProgressListener) {

    fun run() {
        val request = Request.Builder()
                .url("http://ovh.net/files/1Mio.dat")
                .build()

        val client = OkHttpClient.Builder()
                .addNetworkInterceptor {
                    val originalResponse = it.proceed(it.request())
                    originalResponse.newBuilder()
                            .body(ProgressResponseBody(originalResponse.body()!!, progressListener))
                            .build()
                }
                .build()

        val response = client.newCall(request).execute()
        System.out.println(response.body()?.string())
    }
}