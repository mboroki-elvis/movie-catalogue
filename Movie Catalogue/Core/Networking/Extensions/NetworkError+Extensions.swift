import Foundation

extension NetworkError: Equatable {

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {

        switch (lhs, rhs) {

        case (.invalidURL, .invalidURL):
            return true

        case (.invalidData, .invalidData):
            return true

        case (.invalidResponse, .invalidResponse):
            return true

        case let (.fail(lValue1, lValue2), .fail(rValue1, rValue2)):
            return lValue1 == rValue1 && lValue2 == rValue2

        case let (.other(lValue), .other(rValue)):
            return lValue.localizedDescription == rValue.localizedDescription

        default:
            return false
        }
    }
}
