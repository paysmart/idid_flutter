package br.com.useidid.idid_flutter

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import br.com.idid.sdk.IDidAuth
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

const val ididPluginChannel = "br.com.idid.sdk/idid_plugin_channel"

class IdidFlutterPlugin(private val mContext: Context) : FlutterPlugin, MethodCallHandler {
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.flutterEngine.getDartExecutor(), ididPluginChannel)
        channel.setMethodCallHandler(IdidFlutterPlugin(flutterPluginBinding.applicationContext));
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), ididPluginChannel)
            channel.setMethodCallHandler(IdidFlutterPlugin(registrar.activeContext()))
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) = Unit

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "provision" -> provision(call, result)
            "authorize" -> authorize(call, result)
        }
    }

    private fun provision(call: MethodCall, result: Result) {
        Log.d("____", "Provision called")
    }

    private fun authorize(call: MethodCall, result: Result) {
        IDidAuth.getInstance(mContext)
                .authorize(call.argument<String>("authorizationContent")!!)

        result.success("ok")
    }
}
