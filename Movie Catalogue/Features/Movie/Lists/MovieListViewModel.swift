import Foundation
import Observation

@Observable final class MovieListViewModel {
    var movies: [Movie] = []
    var totalPages = 1000
    var currentPage = 1

    private let list: MovieList
    private let datasource: MovieDatasource
    /// The use case for managing favorite movies.
    private let favoritesUseCase: FavoritesUseCase

    /**
     Initializes a new MovieViewModel with the specified data source.
     Parameter datasource: The data source for movie-related operations.
     */
    init(
        datasource: MovieDatasource = MovieDatasourceImplementation(),
        favoritesUseCase: FavoritesUseCase = FavoritesUseCaseImplementation(),
        list: MovieList = .trending
    ) {
        self.datasource = datasource
        self.favoritesUseCase = favoritesUseCase
        self.list = list
    }

    func fetchData(favorites: [Movie]) {
        Task {
            await fetchMovies(page: currentPage, favorites: favorites)
        }
    }

    @MainActor
    private func fetchMovies(page: Int, favorites: [Movie]) async {
        do {
            let moviesResponse: [MovieResponse]
            switch list {
            case .trending:
                moviesResponse = try await datasource.getTrending(page: page)
            case .topRated:
                moviesResponse = try await datasource.topRated(page: page)
            }
            if favorites.isEmpty {
                movies.append(contentsOf: moviesResponse.map { .init(movie: $0) })
            } else {
                favoritesUseCase.treatMovies(response: moviesResponse, favorites: favorites, append: &movies)
            }
            // TODO: For now we are faking the total pages the results response does return the count, we have set the count to 1000
           // totalPages = respnse.totalPages
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
