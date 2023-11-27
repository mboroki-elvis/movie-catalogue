import Foundation
import Observation
import SwiftData

/**
  A view model responsible for managing movie details and interactions.

  The `MovieDetailsViewModel` class provides functionality to fetch details for a specific movie and handle loading states.

  - Requires: The `Observation` and `SwiftData` modules for observable functionality and data storage.

  ### Example Usage:
  ```swift
  @Observable var detailsViewModel = MovieDetailsViewModel(movieID: 123)
  ```
 */
@Observable
final class MovieDetailsViewModel {
    /// An error encountered during data fetching, if any.
    var error: LocalizedError?


    /// A boolean indicating whether the data is currently being loaded.
    private(set) var isLoading = false
    /// The identifier of the movie for which details are fetched.
    var movie: Movie
    /// The data source for movie-related operations.
    private let datasource: MovieDatasource
    private let favoritesUseCase: FavoritesUseCase
    private(set) var isFavorite = false
    /**
     Initializes a new MovieDetailsViewModel with the specified data source and movie identifier.
     Parameters:
     datasource: The data source for movie-related operations.
     movieID: The identifier of the movie for which details are fetched.
     */
    init(
        datasource: MovieDatasource = MovieDatasourceImplementation(),
        favoritesUseCase: FavoritesUseCase = FavoritesUseCaseImplementation(),
        movie: Movie
    ) {
        self.datasource = datasource
        self.favoritesUseCase = favoritesUseCase
        self.movie = movie
    }

    /**
     Asynchronous function triggered when the view associated with this view model appears.
     Note: This function updates the state of movie details.
     Requires: The MainActor attribute for safe UI updates.
     SeeAlso: MovieDatasource
     */
    @MainActor
    func onAppear() {
        Task {
            self.error = nil
            self.isLoading = true
            defer { self.isLoading = false }
            do {
                if let movieResponse = try await datasource.getDetails(movie: movie.id) {
                    self.movie.updatingAllExceptid(movie: movieResponse)
                }
            } catch {
                self.error = error.toLocalizeError
            }
        }
    }

    func toggleIsFavorite(context: ModelContext) {
        do {
            isFavorite = try favoritesUseCase.contextHasMovie(movie: movie, context: context)
        } catch {
            self.error = error.toLocalizeError
        }
    }

    /**
     Adds or deletes the movie details from the specified data context based on its existence.
     Parameter context: The data context where the movie details should be added or deleted.
     */
    func addOrDelete(from context: ModelContext) {
        do {
            defer { toggleIsFavorite(context: context)}
            let hasMovie = try favoritesUseCase.contextHasMovie(movie: movie, context: context)
            if hasMovie {
                try favoritesUseCase.deleteSelectedMovieFromContext(movie: movie, context: context)
            } else {
                try favoritesUseCase.addSelectedMovieToContext(movie: movie, context: context)
            }
        } catch {
            self.error = error.toLocalizeError
        }
    }
}

extension Error {
    var toLocalizeError: LocalizedError? {
        self as? LocalizedError
    }
}
