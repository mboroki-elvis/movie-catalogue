import Foundation

struct CompanyResponse: Codable, Equatable {
    var id: Int
    var logoPath: String?
    let name: String
    var originCountry: String? 
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
