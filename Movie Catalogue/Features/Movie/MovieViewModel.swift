import Foundation
import Observation
import SwiftData

@Observable class MovieViewModel {
    var trending = [Movie]()
    var topRated = [Movie]()
    var isLoading = false
    var presentDialog = false
    var currentSelectedMovie: Movie?
    private let datasource: MovieDatasource
    init(datasource: MovieDatasource = MovieDatasourceImpl()) {
        self.datasource = datasource
    }

    @MainActor
    func onAppear() {
        Task {
            self.isLoading = true

            defer { self.isLoading = false }
            do {
                self.topRated = try await datasource.topRated()
                self.trending = try await datasource.getTrending()
            } catch {
                print(error)
            }
        }
    }
    

    func addSelectedMovieToContext(context: ModelContext) {
        guard let currentSelectedMovie else { return }
        context.insert(currentSelectedMovie)
        self.currentSelectedMovie = nil
    }

    func deleteSelectedMovieFromContext(context: ModelContext) {
        guard let currentSelectedMovie else { return }
        context.delete(currentSelectedMovie)
        self.currentSelectedMovie = nil
    }

    func isSelectedMovieFavourited(movies: [Movie]) -> Bool {
        guard let currentSelectedMovie else { return false }
        return movies.contains(currentSelectedMovie)
    }
}
