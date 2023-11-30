import Foundation
import SwiftData

@Model
class Genre: Identifiable {
    @Attribute(.unique) let id = UUID()
    var name: String?
    var apiID: Int
    var movie: FavoriteMovie?
    init(apiID: Int, name: String? = nil, movie: FavoriteMovie? = nil) {
        self.apiID = apiID
        self.name = name
        self.movie = movie
    }
}

extension Genre {
    @discardableResult
    convenience init(genre: GenreResponse, movie: FavoriteMovie? = nil) {
        self.init(
            apiID: genre.id,
            name: genre.name,
            movie: movie
        )
    }

    func updatingPropertiesExceptID(genre: GenreResponse) {
        self.name = genre.name
    }
}
