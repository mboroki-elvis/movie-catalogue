import Foundation
import Observation
import SwiftData

@Observable class MovieDetailsViewModel {
    var movie: Movie?
    var isLoading = false
    private let id: Int
    private let datasource: MovieDatasource
    init(datasource: MovieDatasource = MovieDatasourceImplimentation(), movie id: Int) {
        self.datasource = datasource
        self.id = id
    }

    @MainActor
    func onAppear() {
        Task {
            self.isLoading = true

            defer { self.isLoading = false }
            do {
                self.movie = try await datasource.getDetails(movie: id)
            } catch {
                print(error)
            }
        }
    }
    

    func addSelectedMovieToContext(context: ModelContext) {
        guard let movie else { return }
        context.insert(movie)
    }

    func deleteSelectedMovieFromContext(context: ModelContext) {
        guard let movie else { return }
        context.delete(movie)
    }
}
