import Foundation

protocol AppEnvironment {
    var baseURL: String { get }
    var userDefaults: UserDefaults { get set }
    func getEnvironment() -> String
    func setEnvironment(_ environment: String)
}

extension AppEnvironment {
    func getEnvironment() -> String {
        if let selectedEnv = userDefaults.object(forKey: .selectedEnvironment) as? String {
            return selectedEnv
        }

        return string(for: "API_ROOT")
    }

    func setEnvironment(_ environment: String) {
        userDefaults.set(environment, forKey: .selectedEnvironment)
    }

    private func string(for key: String) -> String {
        Bundle.main.infoDictionary?[key] as! String
    }
}

struct EnvironmentLive: AppEnvironment {
    var userDefaults: UserDefaults = .standard

    var apiBaseURL: URL { URL(string: "https://api.themoviedb.org/3/")! }

    var baseURL: String { "\(apiBaseURL)" }

    init() {}
}

struct EnvironmentMock: AppEnvironment {
    var userDefaults: UserDefaults = UserDefaultsMock()

    var baseURL: String { "" }

    init() {}
}

final class UserDefaultsMock: UserDefaults {
    convenience init() {
        self.init(suiteName: "Mock User Defaults")!
    }

    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
    }
}
