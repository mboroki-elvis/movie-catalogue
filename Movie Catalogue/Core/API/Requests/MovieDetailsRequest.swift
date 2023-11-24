import Foundation

struct MovieDetailsRequest: APIRequest {
    var endpoint: String { MovieAPI.details(movieId).api }
    
    var method: HTTPMethod { .get }
    
    var headers: [String: String] = [:]
    let movieId: Int
    init(movie id: Int) {
        self.movieId = id
    }

    func response(networkClient: NetworkClient) async throws -> MovieResponse? { nil }
}
