package br.com.useidid.idid_flutter

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import br.com.idid.sdk.IDidAuth
import br.com.idid.sdk.IDidProvisionCallback
import br.com.idid.sdk.messages.IDidProvisionFailed
import br.com.idid.sdk.messages.IDidProvisionPayload
import br.com.idid.sdk.messages.IDidProvisionSucceed
import br.com.idid.sdk.models.IDidDeliveryAddress
import br.com.idid.sdk.provisioning.IDidDataPrepSpec

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

        val payload = IDidProvisionPayload(
                userName = call.argument<String>("name")!!,
                userEmail = call.argument<String>("email")!!,
                issuerId = call.argument<String>("issuerId")!!,
                phoneNumber = call.argument<String>("phoneNumber")!!,
                documentId = call.argument<String>("documentId")!!,
                address = IDidDeliveryAddress(
                        streetAddress = "Manoelito de Ornelas",
                        neighborhood = "Praia de Belas",
                        complement = "Paysmart Matrix",
                        city = "Porto Alegre",
                        zipcode = "90110230",
                        streetNumber = "55",
                        country = "Brazil",
                        state = "RS"
                ),
                dataPrep = IDidDataPrepSpec(
                        mKDI = 2,
                        mScheme = "ELO",
                        mProductType = "Debit",
                        mPANSequence = 0,
                        mDerivationKey = call.argument<String>("derivationKey")!!,
                        mTrack2EqData = call.argument<String>("track2")!!,
                        mExpirationDate = 1734460825000
                )
        )

        val callback = object : IDidProvisionCallback(payload) {
            override fun onError(error: IDidProvisionFailed?) {
                Log.d("____", "Provision Failed ${error?.message}")
            }

            override fun onSuccess(value: IDidProvisionSucceed?) {
                Log.d("____", "Provision Succeed with id = ${value?.cardId}")
            }
        }

        IDidAuth.getInstance(mContext)
                .provision(callback)
    }

    private fun authorize(call: MethodCall, result: Result) {
        IDidAuth.getInstance(mContext)
                .authorize(call.argument<String>("authorizationContent")!!)

        result.success("ok")
    }
}
