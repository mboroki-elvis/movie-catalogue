import Foundation
import SwiftData

protocol FavoritesUseCase: AnyObject {
    var movie: Movie? { get set }
    func addSelectedMovieToContext(context: ModelContext) throws
    func deleteSelectedMovieFromContext(context: ModelContext) throws
    func contextHasMovie(context: ModelContext) throws -> Bool
}

final class FavoritesUseCaseImplementation: FavoritesUseCase {
    var movie: Movie?
    func addSelectedMovieToContext(context: ModelContext) throws {
        guard let movie else { throw FavoritesSaveError.noMovie }
        let exist = try contextHasMovie(context: context)
        guard !exist else { throw FavoritesSaveError.saveError }
        context.insert(movie)
        self.movie = nil
    }

    func deleteSelectedMovieFromContext(context: ModelContext) throws {
        guard let movie else { throw FavoritesSaveError.noMovie }
        let exist = try contextHasMovie(context: context)
        guard exist else { throw FavoritesSaveError.deleteError }
        context.delete(movie)
        self.movie = nil
    }

    /**
     Checks if the specified movie exists in the given data context.
     Parameters:
     movie: The movie to check for existence.
     context: The data context to search for the movie.
     Returns: A boolean value indicating whether the movie exists in the data context.
     */
    func contextHasMovie(context: ModelContext) throws -> Bool {
        guard let movie else { throw FavoritesSaveError.noMovie }
        let id = movie.id
        let predicate = #Predicate<Movie> { $0.id == id }
        let fetchedMovie = try context.fetch(FetchDescriptor<Movie>(predicate: predicate, sortBy: [SortDescriptor(\.id)]))
        return !fetchedMovie.isEmpty
    }
}

extension FavoritesUseCaseImplementation {
    enum FavoritesSaveError: Error {
        case deleteError
        case saveError
        case noMovie
    }
}
