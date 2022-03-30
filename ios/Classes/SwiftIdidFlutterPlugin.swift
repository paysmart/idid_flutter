import Flutter
import UIKit
import iDid

public class SwiftIdidFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "br.com.idid.sdk/idid_plugin_channel", binaryMessenger: registrar.messenger())
    let instance = SwiftIdidFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    // result("iOS " + UIDevice.current.systemVersion)

    guard let method = IDidChannelMethod(rawValue: call.method) else {
      result(FlutterMethodNotImplemented)
      return
    }

    let arguments = call.arguments as? [String: Any]
    method.call(arguments: arguments, result: result)

  }

}

enum IDidChannelMethod: String {
  case isProvisioned
  case unProvision
  case authorize
  case provision

  func call(arguments: [String: Any]?, result: @escaping FlutterResult) {

    let runner: (_ arguments: [String: Any]?, _ result: @escaping FlutterResult) -> Void

    switch self {
    case .isProvisioned:    runner = isProvisioned
    case .unProvision:      runner = unProvision
    case .authorize:        runner = authorize
    case .provision:        runner = provision
    }
    runner(arguments, result)
  }
}
extension IDidChannelMethod {

  func isProvisioned(arguments: [String: Any]?, result: @escaping FlutterResult) {
       
    let auth = IDidAuthManager.instance

    result(auth.isProvisioned())

  }

  func unProvision(arguments: [String: Any]?, result: @escaping FlutterResult) {

    guard let args = arguments else {
      result(FlutterMethodNotImplemented)
      return
    }

      let payload = IDidUnProvisionPayload(
        issuerId: args["issuerId"] as? String ?? ""
      )

    let callback = callbackUnProvision(mPayload: payload, result: result)

    let auth = IDidAuthManager.instance

    try! auth.unProvision(callback: callback)

  }

  struct callbackUnProvision: IDidUnProvisionCallback {
    var mPayload: IDidUnProvisionPayload
    var result: FlutterResult
    
    func onError(error: IDidUnProvisionFailed) {
        print("Erro no desprovisionamento. Erro: \(error.message)")
        result("Failed")
    }
    
    func onSuccess(value: IDidUnProvisionSucceed) {
        print("Desprovisionamento realizado com sucesso!")
        result("Succeeded")
    }
  }


  func authorize(arguments: [String: Any]?, result: @escaping FlutterResult) {

    guard let args = arguments else {
      result(FlutterMethodNotImplemented)
      return
    }

    let auth = IDidAuthManager.instance
    auth.authorize(transaction: args["authorizationContent"] as? String ?? "")
    result("ok")
    
  }

  func provision(arguments: [String: Any]?, result: @escaping FlutterResult) {

    guard let args = arguments else {
      result(FlutterMethodNotImplemented)
      return
    }

    var dateComponents = DateComponents()
    dateComponents.month = 10
    dateComponents.day = 10
    dateComponents.year = 2021
    let calendar = Calendar(identifier: .gregorian)
    let dateExp = (calendar.date(from: dateComponents) ?? Date()).millisecondsSince1970

    let address = IDidAddress(
                        streetAddress: "Manoelito de Ornelas",
                        streetNumber: "55",
                        complement: "Paysmart Matrix",
                        neighborhood: "Praia de Belas",
                        city: "Porto Alegre",
                        state: "RS",
                        zipcode: "90110230",
                        addressType: "R",
                        country: "Brazil"
      )

    let dataPrepSpec = IDidDataPrepSpec(
        mKDI: 2,
        mScheme: "ELO",
        mPANSequence: 0,
        mProductType: "Debit",
        mTrack2EqData: args["track2"] as? String ?? "",
        mExpirationDate: dateExp,
        mDerivationKey: args["derivationKey"] as? String ?? ""
    )
            
    let payload = IDidProvisionPayload(
        issuerId: args["issuerId"] as? String ?? "",
        userName: args["name"] as? String ?? "",
        userEmail: args["email"] as? String ?? "",
        documentId: args["documentId"] as? String ?? "",
        phoneNumber: args["phoneNumber"] as? String ?? "",
        address: address, 
        dataPrep: dataPrepSpec
    )

    let callback = callbackProvision(mPayload: payload, result: result)

    let auth = IDidAuthManager.instance

    try! auth.provision(callback: callback)

  }
  struct callbackProvision: IDidProvisionCallback {
    var mPayload: IDidProvisionPayload
    var result: FlutterResult
    
    func onError(error: IDidProvisionFailed) {
        print("Erro no provionamento. Erro: \(error.message)")
        result("Failed")
    }
    
    func onSuccess(value: IDidProvisionSucceed) {
        print("Cliente cadastro com sucesso. ID: \(value.cardId)")
        result("Succeeded")
    }
  }


}

public class IDidAuthManager {

    public static var instance: IDidAuth = {
        let instance = IDidAuth()
        return instance
    }()

    private init() {}

}
