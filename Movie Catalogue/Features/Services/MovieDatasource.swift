import Foundation

/**
 A protocol defining the requirements for a movie data source.

 The `MovieDatasource` protocol specifies methods for fetching top-rated movies, trending movies, and movie details.
 */
protocol MovieDatasource {
    /// Asynchronously fetches a list of top-rated movies.
    func topRated() async throws -> [Movie]

    /// Asynchronously fetches a list of trending movies.
    func getTrending() async throws -> [Movie]

    /// Asynchronously fetches details for a specific movie.
    func getDetails(movie id: Int) async throws -> Movie?
}

/**
  A concrete implementation of the `MovieDatasource` protocol.

  The `MovieDatasourceImpl` class utilizes a network client to make API requests for movie-related data.

  - Requires: The `NetworkClient` and `Environment` modules.

  ### Example Usage:
  ```swift
  let datasource = MovieDatasourceImpl()
 ```
 */
class MovieDatasourceImplimentation: MovieDatasource {
    /// The network client for making API requests.
    let client: NetworkClient
    let environment: AppEnvironment
    /**
     Initializes a new MovieDatasourceImpl with the specified network client.
     Parameter client: The network client for making API requests.
     */
    init(
        client: NetworkClient = NetworkClientImpl(environment: EnvironmentLive()),
        environment: AppEnvironment = EnvironmentLive()
    ) {
        self.client = client
        self.environment = environment
    }

    /**
     Asynchronously fetches a list of top-rated movies.
     Returns: An array of Movie objects representing top-rated movies.
     Throws: An error of type MovieAPIError if the request encounters an issue.
     */
    func topRated() async throws -> [Movie] {
        do {
            let request = TopRatedRequest()
            if let response = try await request.doRequest(environment: environment, client) {
                return response.results.map { Movie(movie: $0) }
            }
            throw MovieAPIError.badRequest
        } catch APIException.unknownError {
            throw MovieAPIError.unknownError
        } catch {
            throw MovieAPIError.movieError(error)
        }
    }

    /**
     Asynchronously fetches a list of trending movies.
     Returns: An array of Movie objects representing trending movies.
     Throws: An error of type MovieAPIError if the request encounters an issue.
     */
    func getTrending() async throws -> [Movie] {
        do {
            let request = TrendingMoviesRequest()
            if let response = try await request.doRequest(environment: environment, client) {
                return response.results.map { Movie(movie: $0) }
            }
            throw MovieAPIError.badRequest
        } catch APIException.unknownError {
            throw MovieAPIError.unknownError
        } catch {
            throw MovieAPIError.movieError(error)
        }
    }

    /**
     Asynchronously fetches details for a specific movie.
     Parameter id: The identifier of the movie for which details are requested.
     Returns: A Movie object representing the details of the specified movie, or nil if not found.
     Throws: An error of type MovieAPIError if the request encounters an issue.
     */
    func getDetails(movie id: Int) async throws -> Movie? {
        do {
            let request = MovieDetailsRequest(movie: id)
            if let movie = try await request.doRequest(environment: environment, client) {
                return Movie(movie: movie)
            }
            throw MovieAPIError.badRequest
        } catch APIException.unknownError {
            throw MovieAPIError.unknownError
        } catch {
            throw MovieAPIError.movieError(error)
        }
    }
}

private extension MovieDatasourceImplimentation {
    /// Enumeration defining errors specific to the movie API.
    enum MovieAPIError: Error {
        case badRequest
        case unknownError
        case movieError(Error)
    }
}
