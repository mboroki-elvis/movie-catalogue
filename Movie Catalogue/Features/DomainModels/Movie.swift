import Foundation
import SwiftData

@Model
final class Movie: Identifiable {
    @Attribute(.unique) var id: Int
    var adult: Bool?
    var backdropPath: String?
    var budget: Int?
    var collection: CollectionResponse?
    var genres: [GenreResponse]?
    var homepage: String?
    var imdbID: ExternalIDType?
    var mediaType: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: Date?
    var revenue: Int?
    var runtime: Int?
    var status: String? // change to enum?
    var tagline: String?
    var title: String?
    var video: Bool?
    var voteAverage: Int?
    var voteCount: Int?
    var productionCompanies: [CompanyResponse]?
    var languages: [LanguageResponse]?

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
        voteAverage: Int? = nil,
        voteCount: Int? = nil,
        languages: [LanguageResponse]? = nil,
        productionCompanies: [CompanyResponse]? = nil
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
        self.languages = languages
        self.productionCompanies = productionCompanies
    }

    var backdropURLString: String? {
        guard let backdropPath else { return nil }
        return "\(EnvironmentLive().imageURL)w300\(backdropPath)"
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
            voteAverage: movie.voteAverage?.roundedInt,
            voteCount: movie.voteCount,
            languages: movie.spokenLanguages,
            productionCompanies: movie.productionCompanies
        )
    }

    func updatingAllExceptid(movie: MovieResponse) {
        self.title = movie.title
        self.adult = movie.adult
        self.backdropPath = movie.backdropPath
        self.budget = movie.budget
        self.collection = movie.collection
        self.genres = movie.genres
        self.homepage = movie.homepage
        self.imdbID = movie.imdbID
        self.mediaType = movie.mediaType
        self.originalTitle = movie.originalTitle
        self.overview = movie.overview
        self.popularity = movie.popularity
        self.releaseDate = movie.releaseDate
        self.revenue = movie.revenue
        self.runtime = movie.runtime
        self.status = movie.status
        self.tagline = movie.tagline
        self.title = movie.title
        self.video = movie.video
        self.voteAverage = movie.voteAverage?.roundedInt
        self.voteCount = movie.voteCount
        self.languages = movie.spokenLanguages
        self.productionCompanies = movie.productionCompanies
    }
}
