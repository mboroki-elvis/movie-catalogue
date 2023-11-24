import Foundation

enum APIException: Error {

    /// Defines a network error. Failing connection for example.
    case networkError(NetworkError)

    /// Fires when there is no access token in keychain
    case invalidApiKey

    /// Defines an unknown error.
    case unknownError
}
