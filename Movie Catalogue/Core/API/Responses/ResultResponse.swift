import Foundation

struct ResultResponse: Codable, Equatable {
    let page: Int
    let results: [MovieResponse]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

//"genres": [
//  {
//    "id": 28,
//    "name": "Action"
//  },
//  {
//    "id": 18,
//    "name": "Drama"
//  }
//],
