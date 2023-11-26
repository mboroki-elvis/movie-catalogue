import Foundation

class NetworkClientMock: NetworkClient {
    // MARK: - Properties

    var endpoint: String?
    var method: HTTPMethod?
    var headers: HTTPHeaders?
    var body: Data?
    var expectedType: Any?

    let responseMock = MockedResponses()

    // MARK: - Initializers

    init() {}

    // MARK: - Protocol Methods

    func get<T: Decodable>(
        endpoint: String,
        headers: HTTPHeaders,
        queryParams: [String : Any]?,
        expecting type: T.Type
    ) async -> Result<T, NetworkError> {
        return await request(
            endpoint: endpoint,
            method: .get,
            headers: headers,
            queryParams: queryParams,
            expecting: type
        )
    }

    func post<T: Decodable>(
        endpoint: String,
        headers: HTTPHeaders,
        body: Data?,
        expecting type: T.Type
    ) async -> Result<T, NetworkError> {
        return await request(
            endpoint: endpoint,
            method: .post,
            headers: headers,
            body: body,
            expecting: type
        )
    }

    // MARK: - Helper Methods

    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        headers: HTTPHeaders,
        body: Data? = nil,
        queryParams: [String : Any]? = nil,
        expecting type: T.Type
    ) async -> Result<T, NetworkError> {
        self.endpoint = endpoint
        self.method = method
        self.headers = headers
        self.body = body
        expectedType = type

        let (mockedErrorData, mockedErrorResponse) = responseMock.mockedErrorResponseFor(endpoint)
        if mockedErrorData != nil || mockedErrorResponse != nil {
            return .failure(.fail(mockedErrorData ?? Data(), mockedErrorResponse ?? HTTPURLResponse()))
        }

        let mockedResponse: T? = responseMock.mockedResponseFor(endpoint)
        if let mockedResponse {
            return .success(mockedResponse)
        }

        return .failure(.invalidResponse)
    }
}
