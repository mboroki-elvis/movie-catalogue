import Foundation
import SwiftData

@Model
final class Movie: Identifiable {
    @Attribute(.unique) var id: Int
    var adult: Bool?
    var backdropPath: String?
    var budget: Int?

    @Relationship(deleteRule: .cascade, inverse: \MovieCollection.movie)
    var collection: MovieCollection?
    @Relationship(deleteRule: .cascade, inverse: \Genre.movie)
    var genres: [Genre]?
    var homepage: String?
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

    @Relationship(deleteRule: .cascade, inverse: \Company.movie)
    var productionCompanies: [Company]?

    @Relationship(deleteRule: .cascade, inverse: \MovieLanguage.movie)
    var languages: [MovieLanguage]?

    init(
        id: Int,
        adult: Bool? = nil,
        backdropPath: String? = nil,
        budget: Int? = nil,
        collection: MovieCollection? = nil,
        genres: [Genre]? = nil,
        homepage: String? = nil,
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
        languages: [MovieLanguage]? = nil,
        productionCompanies: [Company]? = nil
    ) {
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.budget = budget
        self.collection = collection
        self.genres = genres
        self.homepage = homepage
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

    init(movie: MovieResponse) {
        self.id = movie.id
        self.adult = movie.adult
        self.backdropPath = movie.backdropPath
        self.budget = movie.budget
        self.homepage = movie.homepage
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
    }
}

extension Movie {
    func updatingPropertiesExceptID(movie: MovieResponse) {
        self.title = movie.title
        self.adult = movie.adult
        self.backdropPath = movie.backdropPath
        self.budget = movie.budget
        if let collection = self.collection,
           let newCollection = movie.collection,
           collection.id == newCollection.id
        {
            collection.updatingPropertiesExceptID(collection: newCollection)
        } else if let collection = movie.collection {
            self.collection = .init(collection: collection, movie: self)
        }

        if self.genres == nil {
            self.genres = movie.genres?.compactMap { .init(genre: $0) }
        } else {
            movie.genres?.forEach { response in
                if let first = self.genres?.first(where: { $0.apiID == response.id }) {
                    first.updatingPropertiesExceptID(genre: response)
                } else {
                    let genre: Genre = .init(genre: response)
                    genre.movie = self
                    self.genres?.append(genre)
                }
            }
        }
        self.homepage = movie.homepage
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
        if self.languages == nil {
            self.languages = movie.spokenLanguages?.compactMap { .init(language: $0, movie: self) }
        } else {
            movie.spokenLanguages?.forEach { response in
                if let first = self.languages?.first(where: { $0.name == response.name }) {
                    first.updatingPropertiesExceptID(language: response)
                } else {
                    self.languages?.append(.init(language: response, movie: self))
                }
            }
        }
        if self.productionCompanies == nil {
            self.productionCompanies = movie.productionCompanies?.compactMap { .init(company: $0, movie: self) }
        } else {
            movie.productionCompanies?.forEach { response in
                if let first = self.productionCompanies?.first(where: { $0.apiID == response.id }) {
                    first.updatingPropertiesExceptID(company: response)
                } else {
                    self.productionCompanies?.append(.init(company: response, movie: self))
                }
            }
        }
    }
}
