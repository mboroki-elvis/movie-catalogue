import Foundation

enum BaseURL {
    case images
    case api
    var prefix: String {
        switch self {
        case .images:
           return "https://image.tmdb.org/t/p/w300"
        case .api:
            return "https://api.themoviedb.org/3/"
        }
    }
}
