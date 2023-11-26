import Foundation

struct MovieDetailsRequest: APIRequest {
    var endpoint: String { MovieAPI.details(movieId).api }
    
    var method: HTTPMethod { .get }
    
    var headers: [String: String] = [:]
    let movieId: Int
    init(movie id: Int) {
        self.movieId = id
    }
    enum CodingKeys: CodingKey {}
    func response(environment: AppEnvironment, networkClient: NetworkClient) async throws -> MovieResponse? {
        switch environment.apiEnronment {
        case .live:
            return nil
        case .mock:
            return MovieResponse(id: 1)
        case .failing:
            throw APIException.unknownError
        case .failure(let error):
            throw APIException.networkError(.other(error))
        }
    }
}
