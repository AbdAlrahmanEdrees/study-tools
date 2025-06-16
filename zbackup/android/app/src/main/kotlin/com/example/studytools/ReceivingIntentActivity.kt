package com.example.studytools

import android.app.Activity
import android.content.ContentUris
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.provider.DocumentsContract
import android.util.Log
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class ReceivingIntentActivity : Activity() {

    companion object {
        const val CHANNEL = "receive_share_intent"
        const val ENGINE_ID = "background_engine_id"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Transparent background
        window.setBackgroundDrawableResource(android.R.color.transparent)

        // Forward the intent to the background service FlutterEngine
        forwardIntentToFlutter()

        // Finish immediately — no UI, no FlutterEngine launch
        finish()
    }

    private fun forwardIntentToFlutter() {
        try {
            val flutterEngine = FlutterEngineCache.getInstance().get(ENGINE_ID)
            if (flutterEngine == null) {
                Log.e("ShareOverlayActivity", "FlutterEngine not found! Cannot forward intent.")
                return
            }

            val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

            when (intent.action) {
                Intent.ACTION_SEND -> {
                    if ("text/plain" == intent.type) {
                        // Plain text detected
                        val sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
                        if (sharedText != null) {
                            Handler(Looper.getMainLooper()).post {
                                methodChannel.invokeMethod(
                                    "onShareReceived",
                                    mapOf(
                                        "type" to "text",
                                        "text" to sharedText
                                    )
                                )
                            }
                        }
                    } else {
                        // Media/file share
                        val uri = intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)
                        val path = getRealPathFromUri(uri)
                        val uriString = uri?.toString()

                        Handler(Looper.getMainLooper()).post {
                            methodChannel.invokeMethod(
                                "onShareReceived",
                                mapOf(
                                    "type" to "media",
                                    "path" to (path ?: uriString) // fallback to Uri string
                                )
                            )
                        }
                    }
                }

                Intent.ACTION_SEND_MULTIPLE -> {
                    val uris = intent.getParcelableArrayListExtra<Uri>(Intent.EXTRA_STREAM)
                    val paths = uris?.map { getRealPathFromUri(it) ?: it.toString() } ?: emptyList()

                    Handler(Looper.getMainLooper()).post {
                        methodChannel.invokeMethod(
                            "onShareReceived",
                            mapOf(
                                "type" to "media",
                                "paths" to paths
                            )
                        )
                    }
                }

                else -> {
                    Log.w("ShareOverlayActivity", "Unhandled intent action: ${intent.action}")
                }
            }

        } catch (e: Exception) {
            e.printStackTrace()
            Log.e("ShareOverlayActivity", "Error forwarding intent to Flutter: ${e.message}")
        }
    }

    private fun getRealPathFromUri(uri: Uri?): String? {
        if (uri == null) return null

        return try {
            when {
                DocumentsContract.isDocumentUri(this, uri) -> {
                    val docId = DocumentsContract.getDocumentId(uri)
                    if ("com.android.providers.downloads.documents" == uri.authority) {
                        val contentUri = ContentUris.withAppendedId(
                            Uri.parse("content://downloads/public_downloads"),
                            docId.toLong()
                        )
                        getRealPathFromUri(contentUri)
                    } else {
                        null
                    }
                }

                "content" == uri.scheme -> {
                    contentResolver.query(uri, null, null, null, null)?.use { cursor ->
                        if (cursor.moveToFirst()) {
                            val columnIndex = cursor.getColumnIndex(android.provider.MediaStore.MediaColumns.DATA)
                            if (columnIndex != -1) {
                                cursor.getString(columnIndex)
                            } else {
                                null
                            }
                        } else {
                            null
                        }
                    }
                }

                "file" == uri.scheme -> uri.path

                else -> null
            }
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }
}
