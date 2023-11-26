import Foundation

struct TrendingMoviesRequest: APIRequest {
    var endpoint: String { MovieAPI.trending.api }
    var page: Int = 1
    var method: HTTPMethod { .get }
    enum CodingKeys: CodingKey {
        case page
    }

    var headers: [String: String] = [:]
    func response(environment: AppEnvironment, networkClient: NetworkClient) async throws -> ResultResponse? {
        switch environment.apiEnronment {
        case .live:
            return nil
        case .mock:
            return .init(page: 1, results: [MovieResponse(id: 1)], totalPages: 2, totalResults: 3)
        case .failing:
            throw APIException.unknownError
        case .failure(let error):
            throw APIException.networkError(.other(error))
        }
    }
}
