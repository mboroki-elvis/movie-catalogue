import Foundation

enum ExternalIDType: Codable, Equatable {
    case facebook(String)
    case twitter(String)
    case instagram(String)
    case imdb(String)

    var id: String {
        switch self {
        case let .facebook(id),
             let .twitter(id),
             let .instagram(id),
             let .imdb(id):
            return id
        }
    }
}
