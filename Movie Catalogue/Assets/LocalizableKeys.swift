import SwiftUI

enum LocalizableKeys: String {
    case trending = "Trending"
    case addFavorite = "Add Favorite"
    case averageRating = "Average Rating:"
    case favorites = "Favorites"
    case genres = "Genres"
    case languages = "Languages:"
    case popularity = "Popularity"
    case producers = "Producers:"
    case rating = "Rating"
    case released = "Released:"
    case removeFavorite = "Remove Favorite"
    case topRated = "Top Rated"
    case movieDetails = "Movie Details"
    case viewAll = "View All"
    case viewMovieDetails = "View Movie Details"
    case votes = "Votes"
    case error = "Something went wrong!"

    func toLocalizableKey() -> LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }

    func localized(args: CVarArg...) -> String {
        let localized = NSLocalizedString(self.rawValue, comment: self.rawValue)
        return String(format: localized, args)
    }
}

extension Text {
    init(with key: LocalizableKeys) {
        self.init(key.toLocalizableKey())
    }

    init(with key: LocalizableKeys, args: CVarArg...) {
        self.init(key.localized(args: args))
    }
}
