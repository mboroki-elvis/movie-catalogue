import Foundation
import SwiftData

@Model
final class Company: Identifiable {
    @Attribute(.unique) var id = UUID()
    var logoPath: String?
    let apiID: Int
    var name: String
    var originCountry: String?
    var movie: FavoriteMovie?
    init(apiID: Int, logoPath: String? = nil, name: String, originCountry: String? = nil, movie: FavoriteMovie?) {
        self.apiID = apiID
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
        self.movie = movie
    }
}

extension Company {
    convenience init(company: CompanyResponse, movie: FavoriteMovie) {
        self.init(
            apiID: company.id,
            logoPath: company.logoPath,
            name: company.name,
            originCountry: company.originCountry,
            movie: movie
        )
    }

    func updatingPropertiesExceptID(company: CompanyResponse) {
        self.name = company.name
        self.logoPath = company.logoPath
        self.originCountry = company.originCountry
    }
}
