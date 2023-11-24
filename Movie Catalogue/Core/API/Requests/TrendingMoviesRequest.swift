import Foundation

struct TrendingMoviesRequest: APIRequest {
    var endpoint: String { MovieAPI.trending.api }
    
    var method: HTTPMethod { .get }
    
    var headers: [String: String] = [:]
    func response(networkClient: NetworkClient) async throws -> TrendingResponse? { nil }
}
