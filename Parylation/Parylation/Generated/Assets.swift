// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let calendarArrowLeft = ImageAsset(name: "calendar-arrow_left")
  internal static let calendarArrowRight = ImageAsset(name: "calendar-arrow_right")
  internal static let commonClose = ImageAsset(name: "common-close")
  internal static let commonConfirm = ImageAsset(name: "common-confirm")
  internal static let commonDelete = ImageAsset(name: "common-delete")
  internal static let commonTaskPlus = ImageAsset(name: "common-task_plus")
  internal static let dashboardCalendar = ImageAsset(name: "dashboard-calendar")
  internal static let dashboardHome = ImageAsset(name: "dashboard-home")
  internal static let dashboardProfile = ImageAsset(name: "dashboard-profile")
  internal static let homeMissingItems = ImageAsset(name: "home-missing_items")
  internal static let settingsAboutUs = ImageAsset(name: "settings-about_us")
  internal static let settingsChangeEmail = ImageAsset(name: "settings-change_email")
  internal static let settingsChangePassword = ImageAsset(name: "settings-change_password")
  internal static let settingsChangeUsername = ImageAsset(name: "settings-change_username")
  internal static let settingsRateUs = ImageAsset(name: "settings-rate_us")
  internal static let settingsSignout = ImageAsset(name: "settings-signout")
  internal static let taskEditBookmark = ImageAsset(name: "task-edit-bookmark")
  internal static let taskEditDictionary = ImageAsset(name: "task-edit-dictionary")
  internal static let taskEditHeart = ImageAsset(name: "task-edit-heart")
  internal static let taskEditHome = ImageAsset(name: "task-edit-home")
  internal static let taskEditKey = ImageAsset(name: "task-edit-key")
  internal static let taskEditList = ImageAsset(name: "task-edit-list")
  internal static let taskEditMail = ImageAsset(name: "task-edit-mail")
  internal static let taskEditOffice = ImageAsset(name: "task-edit-office")
  internal static let taskEditShop = ImageAsset(name: "task-edit-shop")
  internal static let taskEditStar = ImageAsset(name: "task-edit-star")
  internal static let welcomeBackground = ImageAsset(name: "welcome_background")
  internal static let appLogo = ImageAsset(name: "app_logo")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
