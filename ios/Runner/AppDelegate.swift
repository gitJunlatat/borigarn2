import UIKit
import Flutter
import FirebaseCore
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
      GMSServices.provideAPIKey("AIzaSyCG3Z33xWUkmjilvJYnuT4nuBQltosfnA0")
      GeneratedPluginRegistrant.register(with: self)
      UIApplication.shared.isIdleTimerDisabled = true
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}
