import Foundation

struct TrendingMoviesRequest: APIRequest {
    var endpoint: String { MovieAPI.trending.api }
    var page: Int = 1
    var method: HTTPMethod { .get }
    enum CodingKeys: CodingKey {
        case page
    }

    var headers: [String: String] = [:]
    func response(environment: AppEnvironment, networkClient: NetworkClient) async throws -> ResultResponse? { nil }
}
