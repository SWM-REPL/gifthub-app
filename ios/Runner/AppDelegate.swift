import UIKit
import Flutter
import NaverThirdPartyLogin

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if url.absoluteString.hasPrefix("kakao") {
      super.application(app, open:url, options: options)
      return true
    } else if url.absoluteString.contains("thirdPartyLoginResult") {
      var applicationResult = false
      if !applicationResult {
        applicationResult = NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
      }
      if !applicationResult {
        applicationResult = super.application(app, open: url, options: options)
      }
      return applicationResult
    } else {
      return true
    }
  }
}

