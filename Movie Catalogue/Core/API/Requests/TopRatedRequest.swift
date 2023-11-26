import Foundation

struct TopRatedRequest: APIRequest {
    var endpoint: String { MovieAPI.topRated.api }
    
    var method: HTTPMethod { .get }
    
    var headers: [String: String] = [:]
    func response(environment: AppEnvironment, networkClient: NetworkClient) async throws -> ResultResponse? { nil }
}
