import Foundation

enum MovieAPI {
    case trending
    case topRated
    case details(Int)
    var api: String {
        switch self {
        case .trending:
            return "3/discover/movie"
        case .details(let id):
            return "3/movie/\(id)"
        case .topRated:
            return "3/movie/top_rated"
        }
    }
}
