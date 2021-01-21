// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Accept
  internal static let accept = L10n.tr("Localizable", "accept")
  /// Parylation
  internal static let appName = L10n.tr("Localizable", "app_name")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// Delete
  internal static let homeDeleteButton = L10n.tr("Localizable", "home_delete_button")
  /// Let's plan your 
  internal static let homeGreetingsSubtitle = L10n.tr("Localizable", "home_greetings_subtitle")
  /// Hey, %@!
  internal static func homeGreetingsTitle(_ p1: Any) -> String {
    return L10n.tr("Localizable", "home_greetings_title", String(describing: p1))
  }
  /// Write important things
  internal static let homePlanButton = L10n.tr("Localizable", "home_plan_button")
  /// Ok
  internal static let ok = L10n.tr("Localizable", "ok")
  /// Change email
  internal static let settingsMainChangeEmail = L10n.tr("Localizable", "settings_main_change_email")
  /// Change password
  internal static let settingsMainChangePassword = L10n.tr("Localizable", "settings_main_change_password")
  /// Change username
  internal static let settingsMainChangeUsername = L10n.tr("Localizable", "settings_main_change_username")
  /// Settings
  internal static let settingsMainSection = L10n.tr("Localizable", "settings_main_section")
  /// About us
  internal static let settingsOthersAboutUs = L10n.tr("Localizable", "settings_others_about_us")
  /// Rate us
  internal static let settingsOthersRateUs = L10n.tr("Localizable", "settings_others_rate_us")
  /// Others
  internal static let settingsOthersSection = L10n.tr("Localizable", "settings_others_section")
  /// Confirm new password
  internal static let settingsPopupConfirmNewPassword = L10n.tr("Localizable", "settings_popup_confirm_new_password")
  /// New password
  internal static let settingsPopupNewPassword = L10n.tr("Localizable", "settings_popup_new_password")
  /// Old password
  internal static let settingsPopupOldPassword = L10n.tr("Localizable", "settings_popup_old_password")
  /// Quit
  internal static let settingsPopupSignoutConfirm = L10n.tr("Localizable", "settings_popup_signout_confirm")
  /// This action can't be undone! Do you want to quit anyway?
  internal static let settingsPopupSignoutDescription = L10n.tr("Localizable", "settings_popup_signout_description")
  /// Are you sure?
  internal static let settingsPopupSignoutTitle = L10n.tr("Localizable", "settings_popup_signout_title")
  /// Sign out
  internal static let settingsSignOut = L10n.tr("Localizable", "settings_sign_out")
  /// Update your 
  internal static let settingsSubtitle = L10n.tr("Localizable", "settings_subtitle")
  /// settings
  internal static let settingsSubtitleAccent = L10n.tr("Localizable", "settings_subtitle_accent")
  /// Edit your workspace
  internal static let settingsTitle = L10n.tr("Localizable", "settings_title")
  /// Sign In
  internal static let signInButton = L10n.tr("Localizable", "sign_in_button")
  /// Email
  internal static let signInEmail = L10n.tr("Localizable", "sign_in_email")
  /// Forgot your password?
  internal static let signInForgotPassword = L10n.tr("Localizable", "sign_in_forgot_password")
  /// Password
  internal static let signInPassword = L10n.tr("Localizable", "sign_in_password")
  /// Sign Up
  internal static let signInSignUp = L10n.tr("Localizable", "sign_in_sign_up")
  /// No account yet?
  internal static let signInSignUpCaption = L10n.tr("Localizable", "sign_in_sign_up_caption")
  /// Great to see you again!
  internal static let signInSubtitle = L10n.tr("Localizable", "sign_in_subtitle")
  /// Sign Up
  internal static let signUpButton = L10n.tr("Localizable", "sign_up_button")
  /// Confirm password
  internal static let signUpConfirmPassword = L10n.tr("Localizable", "sign_up_confirm_password")
  /// Email
  internal static let signUpEmail = L10n.tr("Localizable", "sign_up_email")
  /// Password does not match
  internal static let signUpInvalidConfirmPassword = L10n.tr("Localizable", "sign_up_invalid_confirm_password")
  /// Invalid email
  internal static let signUpInvalidEmail = L10n.tr("Localizable", "sign_up_invalid_email")
  /// Invalid password
  internal static let signUpInvalidPassword = L10n.tr("Localizable", "sign_up_invalid_password")
  /// Password
  internal static let signUpPassword = L10n.tr("Localizable", "sign_up_password")
  /// Sign In
  internal static let signUpSignIn = L10n.tr("Localizable", "sign_up_sign_in")
  /// Already a member?
  internal static let signUpSignInCaption = L10n.tr("Localizable", "sign_up_sign_in_caption")
  /// Start using Parylation!
  internal static let signUpSubtitle = L10n.tr("Localizable", "sign_up_subtitle")
  /// Date
  internal static let taskDate = L10n.tr("Localizable", "task_date")
  /// Description
  internal static let taskDescription = L10n.tr("Localizable", "task_description")
  /// Edit
  internal static let taskEditButton = L10n.tr("Localizable", "task_edit_button")
  /// Color
  internal static let taskEditColor = L10n.tr("Localizable", "task_edit_color")
  /// Date
  internal static let taskEditDate = L10n.tr("Localizable", "task_edit_date")
  /// Description
  internal static let taskEditDescription = L10n.tr("Localizable", "task_edit_description")
  /// Icon
  internal static let taskEditIcon = L10n.tr("Localizable", "task_edit_icon")
  /// Edit Task
  internal static let taskEditPageTitle = L10n.tr("Localizable", "task_edit_page_title")
  /// Save
  internal static let taskEditSaveButton = L10n.tr("Localizable", "task_edit_save_button")
  /// Title
  internal static let taskEditTitle = L10n.tr("Localizable", "task_edit_title")
  /// Task
  internal static let taskPageTitle = L10n.tr("Localizable", "task_page_title")
  /// This feature is not working yet. Try again later ;(
  internal static let unavailableFeatureDescription = L10n.tr("Localizable", "unavailable_feature_description")
  /// Oh no...
  internal static let unavailableFeatureTitle = L10n.tr("Localizable", "unavailable_feature_title")
  /// I already have an account
  internal static let welcomeSignIn = L10n.tr("Localizable", "welcome_sign_in")
  /// Sign Up
  internal static let welcomeSignUp = L10n.tr("Localizable", "welcome_sign_up")
  /// Plan Your Day with
  internal static let welcomeSubtitle = L10n.tr("Localizable", "welcome_subtitle")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
