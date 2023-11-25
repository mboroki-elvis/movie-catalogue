import Foundation

struct MovieResponse: Decodable, Equatable {
    var id: Int
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
    var productionCompanies: [CompanyResponse]?
    var releaseDate: Date?
    var revenue: Int?
    var runtime: Int?
    var spokenLanguages: [LanguageResponse]?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        adult = try? container.decode(Bool.self, forKey: .adult)
        backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        budget = try? container.decode(Int.self, forKey: .budget)
        collection = try? container.decode(CollectionResponse.self, forKey: .collection)
        if let genreArray = try? container.decode([GenreResponse].self, forKey: .genres) {
            genres = genreArray
        } else if let genreIDs = try? container.decode([Int].self, forKey: .genreIDs) {
            genres = genreIDs.map { GenreResponse(id: $0) }
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
        productionCompanies = try? container.decode([CompanyResponse].self, forKey: .productionCompanies)

        if let dateString = try? container.decode(String.self, forKey: .releaseDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            releaseDate = dateFormatter.date(from: dateString)
        }
        revenue = try? container.decode(Int.self, forKey: .revenue)
        runtime = try? container.decode(Int.self, forKey: .runtime)
        spokenLanguages = try? container.decode([LanguageResponse].self, forKey: .spokenLanguages)

        status = try? container.decode(String.self, forKey: .status)
        tagline = try? container.decode(String.self, forKey: .tagline)
        title = try? container.decode(String.self, forKey: .title)
        video = try? container.decode(Bool.self, forKey: .video)
        voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        voteCount = try? container.decode(Int.self, forKey: .voteCount)
    }
}
