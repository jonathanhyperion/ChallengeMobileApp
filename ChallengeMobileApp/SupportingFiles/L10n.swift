// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
    internal static let email = L10n.tr("Localizable", "email")
    internal static let password = L10n.tr("Localizable", "password")
    internal static let forgotPassword = L10n.tr("Localizable", "forgotPassword")
    internal static let login = L10n.tr("Localizable", "login")
    internal static let today = L10n.tr("Localizable", "today")
    internal static let enterEmailReset = L10n.tr("Localizable", "enterEmailReset")
    internal static let reset = L10n.tr("Localizable", "reset")
    internal static let logout = L10n.tr("Localizable", "logout")
    internal static let version = L10n.tr("Localizable", "version")
    internal static let startSurvey = L10n.tr("Localizable", "startSurvey")
    internal static let errorLogin = L10n.tr("Localizable", "errorLogin")
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = .init(for: BundleToken.self)
}

// swiftlint:enable convenience_type
