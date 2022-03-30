import UIKit
import Flutter
import iDid

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let notificationManager = IDidNotificationManager()
    notificationManager.register()
    UNUserNotificationCenter.current().delegate = self

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("userNotificaionCenter -> UNNotification")
        
        UserNotificationCenter.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    }

  override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.content.categoryIdentifier == "ididNotificationCenter" {
            UserNotificationCenter.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
            return
        }
        completionHandler()
    }

}
