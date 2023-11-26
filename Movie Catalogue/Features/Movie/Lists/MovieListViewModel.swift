import Foundation
import Observation

@Observable final class MovieListViewModel {
    var movies: [Movie] = []
    var totalPages = 1000
    var currentPage = 1

    private let list: MovieList
    private let datasource: MovieDatasource

    /**
     Initializes a new MovieViewModel with the specified data source.
     Parameter datasource: The data source for movie-related operations.
     */
    init(datasource: MovieDatasource = MovieDatasourceImplementation(), list: MovieList = .trending) {
        self.datasource = datasource
        self.list = list
    }

    func fetchData() {
        Task {
            await fetchMovies(page: currentPage)
        }
    }

    @MainActor
    private func fetchMovies(page: Int) async {
        do {
            let moviesResponse: [MovieResponse]
            switch list {
            case .trending:
                moviesResponse = try await datasource.getTrending(page: page)
            case .topRated:
                moviesResponse = try await datasource.topRated(page: page)
            }
            movies.append(contentsOf: moviesResponse.map { .init(movie: $0) })
//                    totalPages = placeholderResponse.totalPages
        } catch {
            print(error)
        }
    }
}

extension MovieListViewModel {
    enum MovieList {
        case trending
        case topRated
    }
}
