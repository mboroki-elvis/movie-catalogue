import Foundation

struct Movie: Hashable, Identifiable {
    var id: Int
    var adult: Bool?
    var backdropPath: String?
    var budget: Int?
    var collection: CollectionResponse?
    var genres: [GenreResponse]?
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
        self.languages = movie.spokenLanguages
        self.collection = movie.collection
        self.productionCompanies = movie.productionCompanies
        self.genres = movie.genres
    }

    init(favorite: FavoriteMovie) {
        self.id = favorite.id
        self.adult = favorite.adult
        self.backdropPath = favorite.backdropPath
        self.budget = favorite.budget
        self.homepage = favorite.homepage
        self.mediaType = favorite.mediaType
        self.originalTitle = favorite.originalTitle
        self.overview = favorite.overview
        self.popularity = favorite.popularity
        self.releaseDate = favorite.releaseDate
        self.revenue = favorite.revenue
        self.runtime = favorite.runtime
        self.status = favorite.status
        self.tagline = favorite.tagline
        self.title = favorite.title
        self.video = favorite.video
        self.voteAverage = favorite.voteAverage
        self.voteCount = favorite.voteCount
        if let collection = favorite.collection {
            self.collection = .init(
                id: collection.id,
                name: collection.name,
                backdropPath: collection.backdropPath,
                posterPath: collection.posterPath
            )
        }

        if let genres = favorite.genres {
            self.genres = genres.map { .init(id: $0.apiID, name: $0.name) }
        }

        if let companies = favorite.productionCompanies {
            self.productionCompanies = companies.map { .init(id: $0.apiID, logoPath: $0.logoPath, name: $0.name, originCountry: $0.originCountry) }
        }
        
        if let languages = favorite.languages {
            self.languages = languages.map { .init(englishName: $0.englishName, name: $0.name, iso639_1: $0.iso639_1) }
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
