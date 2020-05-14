package br.com.useidid.idid_flutter

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

const val ididPluginChannel = "br.com.idid.sdk/idid_plugin_channel"

class IdidFlutterPlugin : FlutterPlugin, MethodCallHandler {
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), ididPluginChannel)
        channel.setMethodCallHandler(IdidFlutterPlugin());
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), ididPluginChannel)
            channel.setMethodCallHandler(IdidFlutterPlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "provision" -> provision(call, result)
            "authorize" -> authorize(call, result)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) = Unit

    private fun provision(call: MethodCall, result: Result) {}

    private fun authorize(call: MethodCall, result: Result) {
        //IDidAuth.instance.authorize()
    }
}
