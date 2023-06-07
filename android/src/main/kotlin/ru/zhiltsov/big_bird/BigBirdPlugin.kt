package ru.zhiltsov.big_bird

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.util.*


/** BigBirdPlugin */
class BigBirdPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null;

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "big_bird")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "printData") {

      val data = call.argument<ByteArray>("data");

      sharePdf(data!!)

      result.success("");
    } else {
      result.notImplemented()
    }
  }

  fun sharePdf( data: ByteArray) {


    val pdfFile: File = File(activity?.filesDir, "example.pdf")

    try {
      val fos = FileOutputStream(pdfFile)

      fos.write(data)

      fos.flush()
      fos.close()
    } catch (e: IOException) {
      e.printStackTrace()
    }

    val intent = Intent(Intent.ACTION_SEND)

    intent.type = "application/pdf"

    var uri = Uri.fromFile(pdfFile)

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
      uri = FileProvider.getUriForFile(activity!!, BuildConfig.LIBRARY_PACKAGE_NAME + ".provider", pdfFile)
    }

    intent.putExtra(Intent.EXTRA_STREAM, uri)

    activity?.startActivity(intent)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null;
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null;
  }
}
