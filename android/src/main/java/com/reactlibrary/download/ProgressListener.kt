package com.reactlibrary.download

/**
 * Created by mbpeele on 7/31/17.
 */
interface ProgressListener {

    fun update(bytesRead: Long, contentLength: Long, done: Boolean)
}