// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Client Error
  internal static let displayErrorClientErrorName = L10n.tr("Localizable", "displayError_clientErrorName")
  /// Connection error
  internal static let displayErrorConnectionErrorName = L10n.tr("Localizable", "displayError_connectionErrorName")
  /// Empty data received
  internal static let displayErrorEmptyDataName = L10n.tr("Localizable", "displayError_emptyDataName")
  /// Encoding error
  internal static let displayErrorEncodingFailedName = L10n.tr("Localizable", "displayError_encodingFailedName")
  /// Informational error
  internal static let displayErrorInformationalErrorName = L10n.tr("Localizable", "displayError_informationalErrorName")
  /// Parsing error
  internal static let displayErrorJsonParsingFailureName = L10n.tr("Localizable", "displayError_jsonParsingFailureName")
  /// Missing URL error
  internal static let displayErrorMissingURLName = L10n.tr("Localizable", "displayError_missingURLName")
  /// Redirection error
  internal static let displayErrorRedirectionErrorName = L10n.tr("Localizable", "displayError_redirectionErrorName")
  /// Server error
  internal static let displayErrorServerErrorName = L10n.tr("Localizable", "displayError_serverErrorName")
  /// The request contains bad syntax or cannot be fulfilled
  internal static let networkErrorClientErrorDescription = L10n.tr("Localizable", "networkError_clientErrorDescription")
  /// Empty data received
  internal static let networkErrorEmptyDataDescription = L10n.tr("Localizable", "networkError_emptyDataDescription")
  /// Failed to encode data
  internal static let networkErrorEncodingFailedDescription = L10n.tr("Localizable", "networkError_encodingFailedDescription")
  /// The request was received, continuing process
  internal static let networkErrorInformationalErrorDescription = L10n.tr("Localizable", "networkError_informationalErrorDescription")
  /// JSON Parsing Failure
  internal static let networkErrorJsonParsingFailureDescription = L10n.tr("Localizable", "networkError_jsonParsingFailureDescription")
  /// Missing URL error
  internal static let networkErrorMissingURLDescription = L10n.tr("Localizable", "networkError_missingURLDescription")
  /// Further action needs to be taken in order to complete the request
  internal static let networkErrorRedirectionErrorDescription = L10n.tr("Localizable", "networkError_redirectionErrorDescription")
  /// The server failed to fulfil an apparently valid request
  internal static let networkErrorServerErrorDescription = L10n.tr("Localizable", "networkError_serverErrorDescription")
  /// An error due your internet connection
  internal static let networkyErrorConnectionErrorDescription = L10n.tr("Localizable", "networkyError_connectionErrorDescription")
  /// Got it
  internal static let viewControllerExtensionOkButton = L10n.tr("Localizable", "viewControllerExtension_okButton")
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
