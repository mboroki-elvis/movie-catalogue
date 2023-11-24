import Foundation

// MARK: - HTTP Headers

typealias HTTPHeaders = [String: String]

// MARK: - HTTP Methods

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
