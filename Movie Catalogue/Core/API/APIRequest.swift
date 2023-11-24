import Foundation

/// A base protocol fort all API requests
///
protocol APIRequest: Encodable {
    /// Defines the response type. It is infered when implementing the response:for: method
    associatedtype ResponseType: Decodable

    /// The API server path. The full path is constructed by concatenating the existing baseUrl from network client environment.
    var endpoint: String { get }

    /// The HTTP method to use.
    var method: HTTPMethod { get }

    /// A dictionary containing all request headers
    var headers: [String: String] { get }

    /// This method is called before processing any request. If it returns a non-nil result, the processing stops and the call returns the value obtained by this method
    ///
    /// - Parameters:
    ///     - networkClient: The network client.
    ///
    /// - Returns: The server response
    /// - Throws: An ApiError containing all backend error information coming from the server.
    ///
    func response(networkClient: NetworkClient) async throws -> ResponseType?
}

extension APIRequest {
    /// Executes an API call.
    ///
    /// - Parameters:
    ///    - networkClient: the network client to use. It could be real or mock.
    ///
    /// - Returns: the backend response encoded by using the infered request response type.
    /// - Throws: An ApiError exception containing all the information from the server.
    ///
    func doRequest(_ client: NetworkClient) async throws -> ResponseType? {
        if let response = try await response(networkClient: client) {
            return response
        }
        return try await doLiveRequest(client)
    }

    func doLiveRequest(_ client: NetworkClient) async throws -> ResponseType {
        var requestHeaders = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        for (key, value) in headers {
            requestHeaders[key] = value
        }
        requestHeaders["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNGMzMDQ2OWZlOTUwNWZhZDQxZGU4OTBlOTI0NDlkYyIsInN1YiI6IjY1NjBlZTY5MjQ0MTgyMDBhZDVkYTkwMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TlP79QVvfgWKY57u9SZf5bIckQLw_tY3tMBlyDCgojc"
        let jsonData = try JSONEncoder().encode(self)
        let result = await client.request(
            endpoint: endpoint,
            method: method,
            headers: requestHeaders,
            body: method == .get ? nil : jsonData,
            expecting: ResponseType.self
        )
        switch result {
        case let .failure(error):
            switch error {
            case let .fail(_, response):
                if response.statusCode == 401 {
                    throw APIException.invalidApiKey
                }

                throw APIException.unknownError
            default:
                throw APIException.networkError(error)
            }
        case let .success(data):
            return data
        }
    }
}
