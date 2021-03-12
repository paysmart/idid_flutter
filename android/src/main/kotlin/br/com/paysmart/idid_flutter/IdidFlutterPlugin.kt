package br.com.paysmart.idid_flutter

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import br.com.idid.sdk.IDidAuth
import br.com.idid.sdk.IDidProvisionCallback
import br.com.idid.sdk.IDidUnProvisionCallback
import br.com.idid.sdk.messages.*
import br.com.idid.sdk.models.IDidDeliveryAddress
import br.com.idid.sdk.provisioning.IDidDataPrepSpec
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

const val ididPluginChannel = "br.com.idid.sdk/idid_plugin_channel"

class IdidFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, ididPluginChannel)
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "isProvisioned" -> isProvisioned(result)
            "unProvision" -> unProvision(call, result)
            "authorize" -> authorize(call, result)
            "provision" -> provision(call, result)
        }
    }

    private fun provision(call: MethodCall, result: Result) {

        val payload = IDidProvisionPayload(
                phoneNumber = call.argument<String>("phoneNumber")!!,
                documentId = call.argument<String>("documentId")!!,
                issuerId = call.argument<String>("issuerId")!!,
                userEmail = call.argument<String>("email")!!,
                userName = call.argument<String>("name")!!,
                address = IDidDeliveryAddress(
                        streetAddress = "Manoelito de Ornelas",
                        neighborhood = "Praia de Belas",
                        complement = "Paysmart Matrix",
                        city = "Porto Alegre",
                        zipcode = "90110230",
                        streetNumber = "55",
                        country = "Brazil",
                        addressType = "R",
                        state = "RS"
                ),
                dataPrep = IDidDataPrepSpec(
                        mDerivationKey = call.argument<String>("derivationKey")!!,
                        mTrack2EqData = call.argument<String>("track2")!!,
                        mProductType = "Debit",
                        mPANSequence = 0,
                        mScheme = "ELO",
                        mKDI = 2
                )
        )

        val callback = object : IDidProvisionCallback(payload) {
            override fun onError(error: IDidProvisionFailed?) {
                result.success("Failed")
            }

            override fun onSuccess(value: IDidProvisionSucceed?) {
                result.success("Succeeded")
            }
        }

        IDidAuth.getInstance(context).provision(callback)
    }

    private fun unProvision(call: MethodCall, result: Result) {
        val callback = object : IDidUnProvisionCallback(
                mPayload = IDidUnProvisionPayload(
                        issuerId = call.argument<String>("issuerId")!!
                )
        ) {
            override fun onError(error: IDidUnProvisionFailed?) {
                Log.d("____", "Un provision Failed ${error?.message}")
                result.success("Failed")
            }

            override fun onSuccess(value: IDidUnProvisionSucceed?) {
                Log.d("____", "Un provision Succeed")
                result.success("Succeeded")
            }
        }

        IDidAuth.getInstance(context).unProvision(callback)
    }

    private fun authorize(call: MethodCall, result: Result) {
        IDidAuth.getInstance(context).authorize(call.argument<String>("authorizationContent")!!)
        result.success("ok")
    }

    private fun isProvisioned(result: Result) {
        result.success(IDidAuth.getInstance(context).isProvisioned)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}
}
