import Foundation
import SwiftData

protocol FavoritesUseCase: AnyObject {
    func addSelectedMovieToContext(movie: Movie, context: ModelContext) throws
    func deleteSelectedMovieFromContext(movie: Movie, context: ModelContext) throws
    func contextHasMovie(movie: Movie, context: ModelContext) throws -> Bool
    func findMovieBy(id: Int, context: ModelContext) throws -> Movie?
}

final class FavoritesUseCaseImplementation: FavoritesUseCase {
    func addSelectedMovieToContext(movie: Movie, context: ModelContext) throws {
        let exist = try contextHasMovie(movie: movie, context: context)
        guard !exist else { throw FavoritesSaveError.saveError(movie.title ?? "") }
        context.insert(movie)
    }

    func deleteSelectedMovieFromContext(movie: Movie, context: ModelContext) throws {
        let exist = try contextHasMovie(movie: movie, context: context)
        guard exist else { throw FavoritesSaveError.deleteError(movie.title ?? "") }
        context.delete(movie)
    }

    /**
     Checks if the specified movie exists in the given data context.
     Parameters:
     movie: The movie to check for existence.
     context: The data context to search for the movie.
     Returns: A boolean value indicating whether the movie exists in the data context.
     */
    func contextHasMovie(movie: Movie, context: ModelContext) throws -> Bool {
        let id = movie.id
        let predicate = #Predicate<Movie> { $0.id == id }
        let fetchedMovie = try context.fetch(FetchDescriptor<Movie>(predicate: predicate, sortBy: [SortDescriptor(\.id)]))
        return !fetchedMovie.isEmpty
    }
    
    func findMovieBy(id: Int, context: ModelContext) throws -> Movie? {
        let predicate = #Predicate<Movie> { $0.id == id }
        let fetchedMovie = try context.fetch(FetchDescriptor<Movie>(predicate: predicate, sortBy: [SortDescriptor(\.id)]))
        return fetchedMovie.first
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
