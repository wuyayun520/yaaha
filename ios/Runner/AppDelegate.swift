import Flutter
import UIKit
import AppTrackingTransparency


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let NefariousMitigate = Int(Date().timeIntervalSince1970)
      
      if NefariousMitigate < 34223 {
          LethargicInnocuous()
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) {
          if #available(iOS 14, *) {
              ATTrackingManager.requestTrackingAuthorization { status in
              }
            }
      }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
