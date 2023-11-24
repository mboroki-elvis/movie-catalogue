import Foundation

enum MovieAPI {
    case trending
    case details(Int)
    var api: String {
        switch self {
        case .trending:
            return "discover/movie"
        case .details(let id):
            return "movie/\(id)"
        }
    }
}
