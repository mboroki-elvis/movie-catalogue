import Foundation

/**
 A protocol defining the requirements for a movie data source.

 The `MovieDatasource` protocol specifies methods for fetching top-rated movies, trending movies, and movie details.
 */
protocol MovieDatasource {
    /// Asynchronously fetches a list of top-rated movies.
    func topRated(page: Int) async throws -> [MovieResponse]

    /// Asynchronously fetches a list of trending movies.
    func getTrending(page: Int) async throws -> [MovieResponse]

    /// Asynchronously fetches details for a specific movie.
    func getDetails(movie id: Int) async throws -> MovieResponse?
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
final class MovieDatasourceImplementation: MovieDatasource {
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
    func topRated(page: Int = 1) async throws -> [MovieResponse] {
        do {
            let request = TopRatedRequest(page: page)
            if let response = try await request.doRequest(environment: environment, client) {
                return response.results
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
    func getTrending(page: Int = 1) async throws -> [MovieResponse] {
        do {
            let request = TrendingMoviesRequest(page: page)
            if let response = try await request.doRequest(environment: environment, client) {
                return response.results
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
    func getDetails(movie id: Int) async throws -> MovieResponse? {
        do {
            let request = MovieDetailsRequest(movie: id)
            return try await request.doRequest(environment: environment, client)
        } catch APIException.unknownError {
            throw MovieAPIError.unknownError
        } catch {
            throw MovieAPIError.movieError(error)
        }
    }
}

private extension MovieDatasourceImplementation {
    /// Enumeration defining errors specific to the movie API.
    enum MovieAPIError: LocalizedError {
        case badRequest
        case unknownError
        case movieError(Error)
        var errorDescription: String? {
            switch self {
            case .badRequest:
                return "Bad Request Check again"
            case .unknownError:
                return "An unkown error has occured, please try again"
            case .movieError(let error):
                return "There was an error on our end, try again later."
            }
        }
    }
}
