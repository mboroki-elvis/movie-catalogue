import Foundation
import SwiftData

@Model
final class MovieLanguage: Identifiable {
    @Attribute(.unique) let id: UUID = UUID()
    var englishName: String
    var name: String
    var iso639_1: String
    var movie: Movie?
    init(englishName: String, name: String, iso639_1: String, movie: Movie?) {
        self.englishName = englishName
        self.name = name
        self.iso639_1 = iso639_1
        self.movie = movie
    }
}

extension MovieLanguage {
    convenience init(language: LanguageResponse, movie: Movie) {
        self.init(
            englishName: language.englishName,
            name: language.name,
            iso639_1: language.iso639_1,
            movie: movie
        )
    }

    func updatingPropertiesExceptID(language: LanguageResponse) {
        self.englishName = language.englishName
        self.name = language.name
        self.iso639_1 = language.iso639_1
    }
}
