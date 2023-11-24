import Foundation

protocol NetworkClient {
    /**
     * Handles the `GET` HTTP requests of an URL.
     *
     *  - Parameters:
     *      - endpoint: the request endpoint String to be sent.
     *      - headers: a list of key-value pairs representing each HTTP header to be passed.
     *      - type: the `Codable` expected type to be returned from the request.
     *
     *  - Returns:
     *      A `Result` with either a successfully decoded `T` object or a `NetworkError`.
     */
    func get<T: Decodable>(
        endpoint: String,
        headers: HTTPHeaders,
        expecting type: T.Type
    ) async -> Result<T, NetworkError>

    /**
     * Handles the `POST` HTTP requests of an URL.
     *
     *  - Parameters:
     *      - endpoint: the request endpoint String to be sent.
     *      - headers: a list of key-value pairs representing each HTTP header to be passed.
     *      - body: optional `Data` to be passed as the HTTP body for the request.
     *      - type: the `Codable` expected type to be returned from the request.
     *
     *  - Returns:
     *      A `Result` with either a successfully decoded `T` object or a `NetworkError`.
     */
    func post<T: Decodable>(
        endpoint: String,
        headers: HTTPHeaders,
        body: Data?,
        expecting type: T.Type
    ) async -> Result<T, NetworkError>

    /**
     * Handles HTTP requests of an URL.
     *
     *  - Parameters:
     *      - endpoint: the request endpoint String to be sent.
     *      - method: the HTTP method to use.
     *      - headers: a list of key-value pairs representing each HTTP header to be passed.
     *      - body: optional `Data` to be passed as the HTTP body for the request.
     *      - type: the `Codable` expected type to be returned from the request.
     *
     *  - Returns:
     *      A `Result` with either a successfully decoded `T` object or a `NetworkError`.
     */
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        headers: HTTPHeaders,
        body: Data?,
        expecting type: T.Type
    ) async -> Result<T, NetworkError>
}
