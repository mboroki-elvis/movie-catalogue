import Foundation
import Observation

@Observable class MovieViewModel {
    private let datasource: MovieDatasource
    var movies = [Movie]()
    var isLoading = false
    init(datasource: MovieDatasource = MovieDatasourceImpl()) {
        self.datasource = datasource
    }

    @MainActor
    func onAppear() {
        Task {
            self.isLoading = true

            defer { self.isLoading = false }
            do {
                self.movies = try await datasource.getTrending()
            } catch {
                print(error)
            }
        }
    }
}
