import UIKit
import Flutter
import flutter_local_notifications
import google_mobile_ads


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
        FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
            GeneratedPluginRegistrant.register(with: registry)
        }
        
        let mediumNativeAdFactory = MediumNativeAdFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "appNativeAdFactoryMedium", nativeAdFactory: mediumNativeAdFactory)
        let smallNativeAdFactory = SmallNativeAdFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "appNativeAdFactorySmall", nativeAdFactory: smallNativeAdFactory)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
