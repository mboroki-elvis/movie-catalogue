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
class MovieDetailsViewModel {
    /// An error encountered during data fetching, if any.
    private(set) var error: Error?
    /// The details of the movie.
    private(set) var movie: Movie?
    /// A boolean indicating whether the data is currently being loaded.
    private(set) var isLoading = false
    /// The identifier of the movie for which details are fetched.
    private let id: Int
    /// The data source for movie-related operations.
    private let datasource: MovieDatasource
    /**
     Initializes a new MovieDetailsViewModel with the specified data source and movie identifier.
     Parameters:
     datasource: The data source for movie-related operations.
     movieID: The identifier of the movie for which details are fetched.
     */
    init(datasource: MovieDatasource = MovieDatasourceImplementation(), movieID id: Int) {
        self.datasource = datasource
        self.id = id
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
                if let movieResponse = try await datasource.getDetails(movie: id) {
                    self.movie = .init(movie: movieResponse)
                }
            } catch {
                self.error = error
            }
        }
    }

    /**
     Adds or deletes the movie details from the specified data context based on its existence.
     Parameter context: The data context where the movie details should be added or deleted.
     */
    func addOrDelete(from context: ModelContext) {
        guard let movie = movie else { return }
        if contextHasMovie(movie, context) {
            deleteSelectedMovieFromContext(context: context)
        } else {
            addSelectedMovieToContext(context: context)
        }
    }

    /**
     Adds the details of the movie to the specified data context.
     Parameter context: The data context where the movie details should be added.
     */
    private func addSelectedMovieToContext(context: ModelContext) {
        guard let movie = movie, !contextHasMovie(movie, context) else { return }
        context.insert(movie)
    }

    /**
     Deletes the details of the movie from the specified data context.
     Parameter context: The data context from which the movie details should be deleted.
     */
    private func deleteSelectedMovieFromContext(context: ModelContext) {
        guard let movie = movie, contextHasMovie(movie, context) else { return }
        context.delete(movie)
    }

    /**
     Checks if the specified movie exists in the given data context.
     Parameters:
     movie: The movie to check for existence.
     context: The data context to search for the movie.
     Returns: A boolean value indicating whether the movie exists in the data context.
     */
    private func contextHasMovie(_ movie: Movie, _ context: ModelContext) -> Bool {
        do {
            let id = movie.id
            let predicate = #Predicate<Movie> { $0.id == id }
            let fetchedMovie = try context.fetch(FetchDescriptor<Movie>(predicate: predicate, sortBy: [SortDescriptor(\.id)]))
            return !fetchedMovie.isEmpty
        } catch {
            print(error)
            return false
        }
    }
}
