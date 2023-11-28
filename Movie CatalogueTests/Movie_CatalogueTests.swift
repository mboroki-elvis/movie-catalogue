//
//  Movie_CatalogueTests.swift
//  Movie CatalogueTests
//
//  Created by Elvis Mwenda on 24/11/2023.
//

@testable import Movie_Catalogue
import SwiftData
import XCTest

final class MovieLandingViewModelTests: XCTestCase {
    var viewModel: MovieLandingViewModel!
    override func setUp() {
        super.setUp()
        viewModel = MovieLandingViewModel(
            datasource: MovieDatasourceImplementation(
                environment: EnvironmentMock()
            ),
            favoritesUseCase: MockFavoritesUseCase()
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
        Task {
            await viewModel.onAppear()
        }
        await Task.yield()
        
        DispatchQueue.main.async {
            expectCompleted.fulfill()
        }
        await fulfillment(of: [expectCompleted])
        // Assert that the view model's properties are updated as expected

        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.topRated.count, 1)
        XCTAssertEqual(viewModel.trending.count, 1)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testOnAppearFailure() async {
        viewModel = MovieLandingViewModel(
            datasource: MovieDatasourceImplementation(
                environment: EnvironmentFailing()
            ),
            favoritesUseCase: MockFavoritesUseCase()
        )
        let expectCompleted = expectation(description: "completed failure")
        Task {
            await viewModel.onAppear()
        }
       
        await Task.yield()

        DispatchQueue.main.async {
            expectCompleted.fulfill()
        }
        await fulfillment(of: [expectCompleted])
        // Assert that the view model's properties are updated as expected

        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.topRated.count, 0)
        XCTAssertEqual(viewModel.trending.count, 0)
        XCTAssertFalse(viewModel.isLoading)
    }
}
