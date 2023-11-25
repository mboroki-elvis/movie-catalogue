import Foundation
import Observation
import SwiftData

@Observable class MovieViewModel {
    var trending = [Movie]()
    var topRated = [Movie]()
    var isLoading = false
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
    
    func addMovieToContext(movie: Movie, context: ModelContext) {
        context.insert(movie)
    }
}
