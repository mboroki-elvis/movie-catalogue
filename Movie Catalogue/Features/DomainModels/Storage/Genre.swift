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
    convenience init(genre: GenreResponse) {
        self.init(
            apiID: genre.id,
            name: genre.name
        )
    }

    func updatingPropertiesExceptID(genre: GenreResponse) {
        self.name = genre.name
    }
}
