import Foundation

class MockedResponses {
    var runAfterMockedErrorResponseForEndpoint: ((String) -> Void)?
    var runAfterMockedResponseForEndpoint: ((String) -> Void)?
    
    private var mockedErrorResponse: [String: HTTPURLResponse] = [:]
    private var mockedErrorData: [String: Data] = [:]
    
    private var mockedResponse: [String: Any] = [:]
    
    init() {
        // let endpointAccounts = "/v1.0/accounts"
        // setTokenRefreshFailure(for: endpointAccounts)
    }
    
    func setMockedErrorResponseFor(_ endpoint: String, data: Data?, response: HTTPURLResponse?) {
        mockedErrorResponse[endpoint] = response
        mockedErrorData[endpoint] = data
    }
    
    func setMockedResponseFor<T: Decodable>(_ endpoint: String, response: T?) {
        mockedResponse[endpoint] = response
    }
    
    func removeMockedResponseFor(_ endpoint: String) {
        mockedErrorData.removeValue(forKey: endpoint)
        mockedErrorResponse.removeValue(forKey: endpoint)
        mockedResponse.removeValue(forKey: endpoint)
    }
    
    func mockedResponseFor<T: Decodable>(_ endpoint: String) -> T? {
        let response = mockedResponse[endpoint] as? T
        if response != nil {
            runAfterMockedResponseForEndpoint?(endpoint)
        }
        return response
    }
    
    func mockedErrorResponseFor(_ endpoint: String) -> (Data?, HTTPURLResponse?) {
        let response = mockedErrorResponse[endpoint]
        let data = mockedErrorData[endpoint]
        if response != nil || data != nil {
            runAfterMockedErrorResponseForEndpoint?(endpoint)
        }
        return (data, response)
    }
}

// helper functions used for testing
extension MockedResponses {
    private func setTokenRefreshFailure(for calledEndpoint: String) {
        let unauthorizedResponse = HTTPURLResponse(url:
            URL(string: "https://www.notimportant.com")!,
            statusCode: 401,
            httpVersion: nil, headerFields: nil)
        
        let tokenExpiredData =
            """
            {
              "message" : "Unauthorized"
            }
            """.data(using: .utf8)
        
        setMockedErrorResponseFor(calledEndpoint, data: tokenExpiredData, response: unauthorizedResponse)
                
        let endpointRefresh = "/v2.0/users/refresh"
        
        let refreshFailedData =
            """
            {
              "ServiceCode" : "0001",
              "Message" : "Unable to refresh token.",
              "Errors" : [
                {
                  "ErrorId" : "0004",
                  "ErrorCode" : "VB.OBIE.Unauthorized.User",
                  "Message" : "Unable to refresh token."
                }
              ],
              "Code" : "ERROR.UNAUTHORIZED",
              "Id" : "4584F0A5-48D2-4012-A0EB-A7D15803225B"
            }
            """.data(using: .utf8)
                            
        setMockedErrorResponseFor(endpointRefresh, data: refreshFailedData, response: unauthorizedResponse)
    }
}
