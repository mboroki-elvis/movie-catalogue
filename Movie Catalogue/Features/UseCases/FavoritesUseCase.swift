import Foundation
import SwiftData

protocol FavoritesUseCase: AnyObject {
    func addSelectedMovieToContext(movie: FavoriteMovie, context: ModelContext) throws
    func deleteSelectedMovieFromContext(movie: FavoriteMovie, context: ModelContext) throws
    func contextHasMovie(movie: FavoriteMovie, context: ModelContext) throws -> Bool
    func findMovieBy(id: Int, context: ModelContext) throws -> FavoriteMovie?
    func fetchAllFavorites(context: ModelContext) throws -> [FavoriteMovie]
    func addRelatedModels(
        genres: [GenreResponse]?,
        collection: CollectionResponse?,
        companies: [CompanyResponse]?,
        languages: [LanguageResponse]?,
        to favourite: FavoriteMovie,
        in context: ModelContext
    )
}

final class FavoritesUseCaseImplementation: FavoritesUseCase {
    func addSelectedMovieToContext(movie: FavoriteMovie, context: ModelContext) throws {
        let exist = try contextHasMovie(movie: movie, context: context)
        guard !exist else { throw FavoritesSaveError.saveError(movie.title ?? "") }
        context.insert(movie)
    }

    func deleteSelectedMovieFromContext(movie: FavoriteMovie, context: ModelContext) throws {
        let exist = try contextHasMovie(movie: movie, context: context)
        guard exist else { throw FavoritesSaveError.deleteError(movie.title ?? "") }
        context.delete(movie)
    }

    func contextHasMovie(movie: FavoriteMovie, context: ModelContext) throws -> Bool {
        let id = movie.id
        let predicate = #Predicate<FavoriteMovie> { $0.id == id }
        let fetchedMovie = try context.fetch(FetchDescriptor<FavoriteMovie>(predicate: predicate, sortBy: [SortDescriptor(\.id)]))
        return !fetchedMovie.isEmpty
    }

    func findMovieBy(id: Int, context: ModelContext) throws -> FavoriteMovie? {
        let predicate = #Predicate<FavoriteMovie> { $0.id == id }
        let fetchedMovie = try context.fetch(FetchDescriptor<FavoriteMovie>(predicate: predicate, sortBy: [SortDescriptor(\.id)]))
        return fetchedMovie.first
    }

    func fetchAllFavorites(context: ModelContext) throws -> [FavoriteMovie] {
        try context.fetch(FetchDescriptor<FavoriteMovie>(sortBy: [SortDescriptor(\.id)]))
    }
    
    func addRelatedModels(
        genres: [GenreResponse]?,
        collection: CollectionResponse?,
        companies: [CompanyResponse]?,
        languages: [LanguageResponse]?,
        to favourite: FavoriteMovie,
        in context: ModelContext
    ) {
        if let collection {
           let collection = MovieCollection(collection: collection, movie: favourite)
            context.insert(collection)
        }
        genres?.forEach {
            context.insert(Genre(genre: $0, movie: favourite))
        }
        companies?.forEach {
            context.insert(Company(company: $0, movie: favourite))
        }
        languages?.forEach {
            context.insert(MovieLanguage(language: $0, movie: favourite))
        }
    }
}

extension FavoritesUseCaseImplementation {
    enum FavoritesSaveError: LocalizedError {
        case deleteError(String)
        case saveError(String)
        case noMovie
        var errorDescription: String? {
            switch self {
            case .deleteError(let name):
                return "Could not delete \(name) from favorites"
            case .saveError(let name):
                return "Could not save \(name) to favorites"
            case .noMovie:
                return "No favorite found"
            }
        }
    }
}
