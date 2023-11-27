@testable import Movie_Catalogue
import SwiftData
import XCTest

final class MovieDetailsTests: XCTestCase {
    var viewModel: MovieDetailsViewModel!
    override func setUp() {
        super.setUp()
        viewModel = MovieDetailsViewModel(
            datasource: MovieDatasourceImplementation(
                environment: EnvironmentMock()
            ),
            favoritesUseCase: MockFavoritesUseCase(), 
            movieID: 1
        )
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Test onAppear method

    func testOnAppearSuccess() async {
        // Call the onAppear method

        let expectCompleted = expectation(description: "completed")
        let task = Task {
            await viewModel.onAppear()
        }
        await Task.yield()
        
        DispatchQueue.main.async {
            expectCompleted.fulfill()
        }
        await fulfillment(of: [expectCompleted])
        // Assert that the view model's properties are updated as expected

        XCTAssertNil(viewModel.error)
        XCTAssertNotNil(viewModel.movie)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testOnAppearFailure() async {
        viewModel = MovieDetailsViewModel(
            datasource: MovieDatasourceImplementation(
                environment: EnvironmentFailing()
            ),
            favoritesUseCase: MockFavoritesUseCase(), 
            movieID: 1
        )
        let expectCompleted = expectation(description: "completed failure")
        let task = Task {
            await viewModel.onAppear()
        }
       
        await Task.yield()

        DispatchQueue.main.async {
            expectCompleted.fulfill()
        }
        await fulfillment(of: [expectCompleted])
        // Assert that the view model's properties are updated as expected

        XCTAssertNotNil(viewModel.error)
        XCTAssertNil(viewModel.movie)
        XCTAssertFalse(viewModel.isLoading)
    }
}
