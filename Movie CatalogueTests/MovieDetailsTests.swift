@testable import Movie_Catalogue
import SwiftData
import XCTest
import Combine

final class MovieDetailsTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var viewModel: MovieDetailsViewModel!
    override func setUp() {
        super.setUp()
        viewModel = MovieDetailsViewModel(
            datasource: MovieDatasourceImplementation(
                environment: EnvironmentMock()
            ),
            favoritesUseCase: MockFavoritesUseCase(isFailing: false),
            movie: defaultMovie
        )
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Test onAppear method

    @MainActor
    func testOnAppearSuccess() {
        // Call the onAppear method

        let expectCompleted = expectation(description: "completed")
        Task {
            viewModel.onAppear(_:)
        }

        DispatchQueue.main.async {
            expectCompleted.fulfill()
        }
       wait(for: [expectCompleted])
        // Assert that the view model's properties are updated as expected

        XCTAssertNil(viewModel.error)
        XCTAssertNotNil(viewModel.movie)
        XCTAssertFalse(viewModel.isLoading)
    }

    @MainActor
    func testOnAppearFailure() {
        viewModel = MovieDetailsViewModel(
            datasource: MovieDatasourceImplementation(
                environment: EnvironmentFailing()
            ),
            favoritesUseCase: MockFavoritesUseCase(isFailing: true),
            movie: .init(id: -1)
        )
        let expectCompleted = expectation(description: "completed failure")
        Task {
            viewModel.onAppear(ModelContext(MovieCatalogueApp.sharedModelContainer))
        }
        
        viewModel.error.publisher.sink { error in
            expectCompleted.fulfill()
        }
        .store(in: &cancellables)
        wait(for: [expectCompleted])

        XCTAssertFalse(viewModel.isLoading)
    }
}


protocol SystemContext {
    
}

extension ModelContext: SystemContext {
    
}
