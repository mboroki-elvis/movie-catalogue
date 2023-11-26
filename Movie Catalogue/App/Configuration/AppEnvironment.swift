import Foundation

protocol AppEnvironment {
    var apiKey: String { get }
    var baseURL: String { get }
    var imageURL: String { get }
    func string(for key: EnvironmentKeys) -> String
}

extension AppEnvironment {
    func string(for key: EnvironmentKeys) -> String {
        Bundle.main.infoDictionary?[key.rawValue] as! String
    }
}

struct EnvironmentLive: AppEnvironment {
    var apiKey: String { string(for: .apiKey) }
    var imageURL: String { string(for: .imageURL) }
    var baseURL: String { string(for: .apiURL) }
}

struct EnvironmentMock: AppEnvironment {
    var apiKey: String { "" }
    var imageURL: String { "" }
    var baseURL: String { "" }
}

enum EnvironmentKeys: String {
    case apiKey = "API_KEY"
    case apiURL = "APP_BASE_URL"
    case imageURL = "IMAGE_BASE_URL"
}
