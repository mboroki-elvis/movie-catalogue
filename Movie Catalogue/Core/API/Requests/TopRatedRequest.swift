import Foundation

struct TopRatedRequest: APIRequest {
    var endpoint: String { MovieAPI.topRated.api }
    
    var method: HTTPMethod { .get }
    var page: Int = 1
    enum CodingKeys: CodingKey {
        case page
    }
    var headers: [String: String] = [:]
    func response(environment: AppEnvironment, networkClient: NetworkClient) async throws -> ResultResponse? { nil }
}
