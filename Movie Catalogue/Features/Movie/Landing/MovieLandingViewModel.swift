import Foundation
import Observation
import SwiftData

/**
  A view model responsible for managing movie-related data and interactions.

  The `MovieViewModel` class provides functionality to fetch trending and top-rated movies, handle loading states, and manage the state of selected movies within a context.

  - Requires: The `Observation` and `SwiftData` modules for observable functionality and data storage.

  ### Example Usage:
  ```swift
  @Bindable var movieViewModel = MovieViewModel()
 ```
 */
@Observable
class MovieLandingViewModel {
    /// An array of trending movies.
    var trending = [Movie]()
    /// An array of top-rated movies.
    var topRated = [Movie]()
    /// A boolean indicating whether the data is currently being loaded.
    var isLoading = false
    /// A boolean indicating whether a dialog should be presented.
    var presentDialog = false
    /// The currently selected movie.
    var currentSelectedMovie: Movie?
    /// The data source for movie-related operations.
    private let datasource: MovieDatasource
    /**
     Initializes a new MovieViewModel with the specified data source.
     Parameter datasource: The data source for movie-related operations.
     */
    init(datasource: MovieDatasource = MovieDatasourceImplementation()) {
        self.datasource = datasource
    }

    /**
     Asynchronous function triggered when the view associated with this view model appears.
     Note: This function updates the state of trending and top-rated movies.
     Requires: The MainActor attribute for safe UI updates.
     SeeAlso: MovieDatasource
     */
    @MainActor
    func onAppear() {
        Task {
            self.isLoading = true
            defer { self.isLoading = false }
            do {
                let ratedResponse = try await datasource.topRated(page: 1)
                self.topRated = ratedResponse.map { .init(movie: $0)}
                let tendingResponse = try await datasource.getTrending(page: 1)
                self.trending = tendingResponse.map { .init(movie: $0)}
            } catch {
                print(error)
            }
        }
    }

    /**
     Adds the currently selected movie to the specified data context.
     Parameter context: The data context where the movie should be added.
     */
    func addSelectedMovieToContext(context: ModelContext) {
        guard let currentSelectedMovie = currentSelectedMovie else { return }
        context.insert(currentSelectedMovie)
        self.currentSelectedMovie = nil
    }

    /**
     Deletes the currently selected movie from the specified data context.
     Parameter context: The data context from which the movie should be deleted.
     */
    func deleteSelectedMovieFromContext(context: ModelContext) {
        guard let currentSelectedMovie = currentSelectedMovie else { return }
        context.delete(currentSelectedMovie)
        self.currentSelectedMovie = nil
    }

    /**
     Checks if the currently selected movie is favorited in the given list of movies.
     Parameter movies: The list of movies to check for favoritism.
     Returns: A boolean indicating whether the selected movie is favorited.
     */
    func isSelectedMovieFavourited(movies: [Movie]) -> Bool {
        guard let currentSelectedMovie = currentSelectedMovie else { return false }
        return movies.contains(currentSelectedMovie)
    }
}
