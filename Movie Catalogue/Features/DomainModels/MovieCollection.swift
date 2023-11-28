import Foundation
import SwiftData

@Model
final class MovieCollection: Identifiable {
    @Attribute(.unique) var id: Int
    var name: String
    var backdropPath: String?
    var posterPath: String?
    var movie: Movie?
    init(id: Int, name: String, backdropPath: String? = nil, posterPath: String? = nil, movie: Movie?) {
        self.id = id
        self.name = name
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.movie = movie
    }
}

extension MovieCollection {
    convenience init(collection: CollectionResponse, movie: Movie) {
        self.init(
            id: collection.id,
            name: collection.name,
            backdropPath: collection.backdropPath,
            posterPath: collection.posterPath,
            movie: movie
        )
    }

    func updatingPropertiesExceptID(collection: CollectionResponse) {
        self.name = collection.name
        self.backdropPath = collection.backdropPath
        self.posterPath = collection.posterPath
    }
}
