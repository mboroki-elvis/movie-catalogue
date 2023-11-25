import Foundation

enum MovieAPI {
    case trending
    case topRated
    case details(Int)
    var api: String {
        switch self {
        case .trending:
            return "discover/movie"
        case .details(let id):
            return "movie/\(id)"
        case .topRated:
            return "movie/top_rated"
        }
    }
}
