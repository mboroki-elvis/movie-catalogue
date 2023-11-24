import Foundation

struct CollectionResponse: Codable, Equatable {
    var id: Int
    var name: String
    var backdropPath: String?
    var posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
