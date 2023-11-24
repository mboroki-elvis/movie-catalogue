import Foundation

/// Contains information about a movie with many optional attributes.
 struct MovieResponse: Codable, Equatable {
    /// The ID of a movie from the database.
    ///
    /// Used in services to fetch additional data for a particular ID.
     var id: Int
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

    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case collection = "belongs_to_collection"
        case genreIDs = "genre_ids"
        case genres
        case homepage
        case imdbID = "imdb_id"
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    enum SpokenLanguageCodingKeys: String, CodingKey {
        case language = "iso_639_1"
    }

    enum ProductionCompanyCodingKeys: String, CodingKey {
        case country = "iso_3166_1"
    }

     func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try? container.encode(adult, forKey: .adult)
        try? container.encode(backdropPath, forKey: .backdropPath)
        try? container.encode(budget, forKey: .budget)
        try? container.encode(collection, forKey: .collection)
        try? container.encode(genres, forKey: .genres)
        try? container.encode(homepage, forKey: .homepage)
        try? container.encode(imdbID?.id, forKey: .imdbID)
        try? container.encode(mediaType, forKey: .mediaType)
        try? container.encode(originalTitle, forKey: .originalTitle)
        try? container.encode(overview, forKey: .overview)
        try? container.encode(popularity, forKey: .popularity)
        try? container.encode(posterPath, forKey: .posterPath)

        if let releaseDate = releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            try? container.encode(dateFormatter.string(from: releaseDate), forKey: .releaseDate)
        }
        try? container.encode(revenue, forKey: .revenue)
        try? container.encode(runtime, forKey: .runtime)
        try? container.encode(status, forKey: .status)
        try? container.encode(tagline, forKey: .tagline)
        try? container.encode(title, forKey: .title)
        try? container.encode(video, forKey: .video)
        try? container.encode(voteAverage, forKey: .voteAverage)
        try? container.encode(voteCount, forKey: .voteCount)
    }

     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        adult = try? container.decode(Bool.self, forKey: .adult)
        backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        budget = try? container.decode(Int.self, forKey: .budget)
        collection = try? container.decode(CollectionResponse.self, forKey: .collection)
        if let genreArray = try? container.decodeIfPresent([GenreResponse].self, forKey: .genres) {
            genres = genreArray
        } else if let genreIDs = try? container.decodeIfPresent([Int].self, forKey: .genreIDs) {
            genres = genreIDs.map({ GenreResponse(id: $0) })
        }
        homepage = try? container.decode(String.self, forKey: .homepage)
        if let imdbIDString = try? container.decode(String.self, forKey: .imdbID) {
            imdbID = ExternalIDType.imdb(imdbIDString)
        }
        mediaType = try? container.decode(String.self, forKey: .mediaType)
        originalTitle = try? container.decode(String.self, forKey: .originalTitle)
        overview = try? container.decode(String.self, forKey: .overview)
        popularity = try? container.decode(Double.self, forKey: .popularity)
        posterPath = try? container.decode(String.self, forKey: .posterPath)

        if let dateString = try? container.decode(String.self, forKey: .releaseDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            releaseDate = dateFormatter.date(from: dateString)
        }
        revenue = try? container.decode(Int.self, forKey: .revenue)
        runtime = try? container.decode(Int.self, forKey: .runtime)

        status = try? container.decode(String.self, forKey: .status)
        tagline = try? container.decode(String.self, forKey: .tagline)
        title = try? container.decode(String.self, forKey: .title)
        video = try? container.decode(Bool.self, forKey: .video)
        voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        voteCount = try? container.decode(Int.self, forKey: .voteCount)
    }
}
