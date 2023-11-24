import Foundation

struct NetworkClientImpl: NetworkClient {
    // MARK: - Properties

    var dump: Bool = true

    private let urlSession: URLSession
    private let environment: AppEnvironment

    // MARK: - Initializers

    init(
        urlSession: URLSession = URLSession.shared,
        environment: AppEnvironment
    ) {
        self.environment = environment
        self.urlSession = urlSession
    }

    // MARK: - Protocol Methods

    func get<T: Decodable>(
        endpoint: String,
        headers: HTTPHeaders,
        expecting type: T.Type
    ) async -> Result<T, NetworkError> {
        await request(
            endpoint: endpoint,
            method: .get,
            headers: headers,
            expecting: type
        )
    }

    func post<T: Decodable>(
        endpoint: String,
        headers: HTTPHeaders,
        body: Data?,
        expecting type: T.Type
    ) async -> Result<T, NetworkError> {
        await request(
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
        expecting type: T.Type
    ) async -> Result<T, NetworkError> {
        do {
            guard let url = URL(string: environment.baseURL + endpoint) else {
                return .failure(NetworkError.invalidURL)
            }

            var request = URLRequest(url: url)

            request.httpMethod = method.rawValue

            headers.forEach { headerField, value in
                request.addValue(value, forHTTPHeaderField: headerField)
            }

            request.httpBody = body

            if dump {
                print("\n\(request.getCurlString(hideToken: false))\n")
            }

            let (data, response) = try await urlSession.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkError.invalidResponse)
            }

            if dump {
                print("HttpStatus: \(httpResponse.statusCode)")
                print("Received:\n\(data.prettyPrinted ?? "{}")\n")
            }

            guard httpResponse.statusCode >= 200, httpResponse.statusCode <= 299 else {
                return .failure(NetworkError.fail(data, httpResponse))
            }

            if type == String.self, data.count == 0 {
                return .success("" as! T)
            }

            let object = try JSONDecoder().decode(type, from: data)
            return .success(object)

        } catch {
            if error is DecodingError {
                print(error)
                return .failure(.invalidData)
            }
            return .failure(.other(error))
        }
    }
}
