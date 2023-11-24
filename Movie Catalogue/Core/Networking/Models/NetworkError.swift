import Foundation

enum NetworkError: Error {

    /**
     * The request URL is invalid.
     */
    case invalidURL

    /**
     *  The returned response is not a HTTP response.
     */
    case invalidResponse

    /**
     *  The HTTP request failed with a non-200 status code.
     */
    case fail(Data, HTTPURLResponse)

    /**
     *  The expected data could not be decoded.
     */
    case invalidData

    /**
     *  Other networking errors.
     */
    case other(Error)
}
