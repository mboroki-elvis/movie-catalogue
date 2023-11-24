import Foundation
import SwiftData

@Model
final class Movie: Identifiable {
    /// The ID of a movie from the database.
    ///
    /// Used in services to fetch additional data for a particular ID.
    @Attribute(.unique) var id: Int
    ///
    var adult: Bool?
    /// The backdrop image path.
    ///
    /// To build an image URL, you will need 3 pieces of data. The `base_url`, `size` and `file_path`. Simply combine them all and you will have a fully qualified URL.
    ///
    /// Here’s an example URL:
    /// ```
    /// https://image.tmdb.org/t/p/w500/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg
    /// ```
    ///
    var backdropPath: String?
    /// The budget for production, rounded to the nearest ``Int``.
    var budget: Int?
    /// The collection of movies that contains this ID.
    var collection: CollectionResponse?
    /// The related genres.
    var genres: [GenreResponse]?
    /// An external website's path.
    ///
    /// This is not necessarily a The Movie Database website.
    var homepage: String?
    /// The IMDB ID.
    var imdbID: ExternalIDType?
    ///
    var mediaType: String?

    /// The official title from its original release.
    var originalTitle: String?
    /// The overview.
    var overview: String?
    /// The popularity rating with respect to The Movie Database.
    var popularity: Double?
    /// The poster image path.
    ///
    /// To build an image URL, you will need 3 pieces of data. The `base_url`, `size` and `file_path`. Simply combine them all and you will have a fully qualified URL.
    ///
    /// Here’s an example URL:
    /// ```
    /// https://image.tmdb.org/t/p/w500/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg
    /// ```
    ///
    var posterPath: String?

    /// The release date.
    var releaseDate: Date?
    /// The revenue generated from the box office.
    var revenue: Int?
    /// The runtime in minutes.
    var runtime: Int?

    /// The production status.
    var status: String? // change to enum?
    /// The tagline.
    var tagline: String?
    /// The title.
    var title: String?
    ///
    var video: Bool?
    /// The average user rating.
    var voteAverage: Double?
    /// The total number of user ratings.
    var voteCount: Int?

    init(
        id: Int,
        adult: Bool? = nil,
        backdropPath: String? = nil,
        budget: Int? = nil,
        collection: CollectionResponse? = nil,
        genres: [GenreResponse]? = nil,
        homepage: String? = nil,
        imdbID: ExternalIDType? = nil,
        mediaType: String? = nil,
        originalTitle: String? = nil,
        overview: String? = nil,
        popularity: Double? = nil,
        releaseDate: Date? = nil,
        revenue: Int? = nil,
        runtime: Int? = nil,
        status: String? = nil,
        tagline: String? = nil,
        title: String? = nil,
        video: Bool? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil
    ) {
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.budget = budget
        self.collection = collection
        self.genres = genres
        self.homepage = homepage
        self.imdbID = imdbID
        self.mediaType = mediaType
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

extension Movie {
    convenience init(movie: MovieResponse) {
        self.init(
            id: movie.id,
            adult: movie.adult,
            backdropPath: movie.backdropPath,
            budget: movie.budget,
            collection: movie.collection,
            genres: movie.genres,
            homepage: movie.homepage,
            imdbID: movie.imdbID,
            mediaType: movie.mediaType,
            originalTitle: movie.originalTitle,
            overview: movie.overview,
            popularity: movie.popularity,
            releaseDate: movie.releaseDate,
            revenue: movie.revenue,
            runtime: movie.runtime,
            status: movie.status,
            tagline: movie.tagline,
            title: movie.title,
            video: movie.video,
            voteAverage: movie.voteAverage,
            voteCount: movie.voteCount
        )
    }
}
