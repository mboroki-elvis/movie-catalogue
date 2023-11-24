import Foundation

protocol MovieDatasource {
    func getTrending() async throws -> [Movie]
    func getDetails(movie id: Int) async throws -> Movie?
}

class MovieDatasourceImpl: MovieDatasource {
    let client: NetworkClient
    init(client: NetworkClient = NetworkClientImpl(environment: EnvironmentLive())) {
        self.client = client
    }

    func getTrending() async throws -> [Movie] {
        do {
            let request = TrendingMoviesRequest()
            if let response = try await request.doRequest(client) {
                return response.results.map { Movie(movie: $0) }
            }
            throw MovieAPIError.badRequest
        } catch APIException.unknownError {
            throw MovieAPIError.unknownError
        } catch {
            throw MovieAPIError.movieError(error)
        }
    }

    func getDetails(movie id: Int) async throws -> Movie? {
        do {
            let request = MovieDetailsRequest(movie: id)
            if let movie = try await request.doRequest(client) {
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

private extension MovieDatasourceImpl {
    enum MovieAPIError: Error {
        case badRequest
        case unknownError
        case movieError(Error)
    }
}
