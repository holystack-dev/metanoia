import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  /// Cover shown while the app is not active.
  ///
  /// iOS has no FLAG_SECURE equivalent, and it snapshots the app for the task
  /// switcher as the app resigns active — so the user's sins list would sit
  /// visible in the switcher for as long as the app is backgrounded. Doing this
  /// from Dart is not reliable: Flutter is not guaranteed to paint another frame
  /// before the snapshot is taken, so the cover has to be a native view.
  private var privacyShield: UIView?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Configure notification center delegate for foreground notifications
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func applicationWillResignActive(_ application: UIApplication) {
    super.applicationWillResignActive(application)
    showPrivacyShield()
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    super.applicationDidBecomeActive(application)
    hidePrivacyShield()
  }

  private func showPrivacyShield() {
    guard privacyShield == nil, let window = self.window else { return }

    let shield = UIVisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))
    shield.frame = window.bounds
    shield.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    // Already in the asset catalog, and carries no user data.
    if let icon = UIImage(named: "LaunchImage") {
      let imageView = UIImageView(image: icon)
      imageView.contentMode = .scaleAspectFit
      imageView.translatesAutoresizingMaskIntoConstraints = false
      shield.contentView.addSubview(imageView)
      NSLayoutConstraint.activate([
        imageView.centerXAnchor.constraint(equalTo: shield.contentView.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: shield.contentView.centerYAnchor),
      ])
    }

    window.addSubview(shield)
    privacyShield = shield
  }

  private func hidePrivacyShield() {
    privacyShield?.removeFromSuperview()
    privacyShield = nil
  }
}
