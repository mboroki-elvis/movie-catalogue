import Foundation
import Observation
import SwiftData

/**
  A view model responsible for managing movie-related data and interactions.

  The `MovieLandingViewModel` class provides functionality to fetch trending and top-rated movies, handle loading states, and manage the state of selected movies within a context.

  - Requires: The `Observation` and `SwiftData` modules for observable functionality and data storage.

  ### Example Usage:
  ```swift
  @Observable var movieLandingViewModel = MovieLandingViewModel()
  ```
 */
@Observable
final class MovieLandingViewModel {
    /// An array of trending movies.
    var trending = [Movie]()
    /// An array of top-rated movies.
    var topRated = [Movie]()
    /// A boolean indicating whether the data is currently being loaded.
    var isLoading = false
    /// A boolean indicating whether a dialog should be presented.
    var presentDialog = false
    /// The currently selected movie.
    var movie: Movie?

    /// An error encountered during data fetching or use case operations.
    var error: LocalizedError?
    /// The data source for movie-related operations.
    private let datasource: MovieDatasource
    /// The use case for managing favorite movies.
    private let favoritesUseCase: FavoritesUseCase
    /**
     Initializes a new MovieLandingViewModel with the specified data source and favorites use case.
     Parameters:
     datasource: The data source for movie-related operations.
     favoritesUseCase: The use case for managing favorite movies.
     */
    init(
        datasource: MovieDatasource = MovieDatasourceImplementation(),
        favoritesUseCase: FavoritesUseCase = FavoritesUseCaseImplementation()
    ) {
        self.datasource = datasource
        self.favoritesUseCase = favoritesUseCase
    }

    /**
     Asynchronous function triggered when the view associated with this view model appears.
     Note: This function updates the state of trending and top-rated movies.
     Requires: The MainActor attribute for safe UI updates.
     SeeAlso: MovieDatasource
     */
    @MainActor
    func onAppear(favorite movies: [Movie]) {
        Task {
            self.error = nil
            self.isLoading = true
            defer { self.isLoading = false }
            do {
                let ratedResponse = try await datasource.topRated(page: 1)
                treatMovies(response: ratedResponse, favorites: movies, append: &topRated)
                let trendingResponse = try await datasource.getTrending(page: 1)
                treatMovies(response: trendingResponse, favorites: movies, append: &trending)
            } catch {
                self.error = error.toLocalizeError
            }
        }
    }

    /**
     Adds the currently selected movie to the specified data context.
     Parameter context: The data context where the movie should be added.
     */
    func addSelectedMovieToContext(context: ModelContext) {
        defer { movie = nil }
        do {
            guard let movie else { return }
            try favoritesUseCase.addSelectedMovieToContext(movie: movie, context: context)
        } catch {
            self.error = error.toLocalizeError
        }
    }

    /**
     Deletes the currently selected movie from the specified data context.
     Parameter context: The data context from which the movie should be deleted.
     */
    func deleteSelectedMovieFromContext(context: ModelContext) {
        defer { movie = nil }
        do {
            guard let movie else { return }
            try favoritesUseCase.deleteSelectedMovieFromContext(movie: movie, context: context)
        } catch {
            self.error = error.toLocalizeError
        }
    }

    /**
     Checks if the currently selected movie is favorited in the given data context.
     Parameter context: The data context to check for favoritism.
     Returns: A boolean indicating whether the selected movie is favorited.
     */
    func isSelectedMovieFavourited(context: ModelContext) -> Bool {
        do {
            guard let movie else { return false }
            return try favoritesUseCase.contextHasMovie(movie: movie, context: context)
        } catch {
            self.error = error.toLocalizeError
            return false
        }
    }
    
    private func treatMovies(
        response: [MovieResponse],
        favorites: [Movie],
        append to: inout [Movie]
    ) {
        response.forEach { response in
            if let movie = favorites.first(where: { $0.id == response.id }) {
                movie.updatingPropertiesExceptID(movie: response)
                to.append(movie)
            } else {
                to.append(.init(movie: response))
            }
        }
    }
}
