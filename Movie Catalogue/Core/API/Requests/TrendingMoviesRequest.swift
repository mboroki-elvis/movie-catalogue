import Foundation

struct TrendingMoviesRequest: APIRequest {
    var endpoint: String { MovieAPI.trending.api }
    
    var method: HTTPMethod { .get }
    
    var headers: [String: String] = [:]
    func response(environment: AppEnvironment, networkClient: NetworkClient) async throws -> ResultResponse? { nil }
}
