import Foundation

struct LanguageResponse: Codable, Equatable {
    let englishName, name, iso639_1: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case name
        case iso639_1 = "iso_639_1"
    }
}
