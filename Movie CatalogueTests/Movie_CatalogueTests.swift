//
//  Movie_CatalogueTests.swift
//  Movie CatalogueTests
//
//  Created by Elvis Mwenda on 24/11/2023.
//

import XCTest
import SwiftData
@testable import Movie_Catalogue

final class MovieLandingViewModelTests: XCTestCase {

    var viewModel: MovieLandingViewModel!
    var favoritesUseCase: MockFavoritesUseCase!
    override func setUp() {
        super.setUp()
        // Initialize the view model with mock dependencies
        favoritesUseCase = MockFavoritesUseCase()
        viewModel = MovieLandingViewModel(
            datasource: MovieDatasourceImplementation(
                environment: EnvironmentMock()
            ),
            favoritesUseCase: favoritesUseCase
        )
    }

    override func tearDown() {
        viewModel = nil
        favoritesUseCase = nil
        super.tearDown()
    }

    // MARK: - Test onAppear method

    @MainActor func testOnAppearSuccess() {

        // Call the onAppear method
        favoritesUseCase.movie = defaultMovie
        viewModel.onAppear()

        // Assert that the view model's properties are updated as expected
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.topRated.count, 1)
        XCTAssertEqual(viewModel.trending.count, 1)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testOnAppearFailure() {
//        // Create a mock error for the datasource
//        let mockError = /* create a mock error here */
//
//        // Inject the mock error into the MockMovieDatasource
//        (viewModel.datasource as? MockMovieDatasource)?.mockError = mockError
//
//        // Call the onAppear method
//        viewModel.onAppear()
//
//        // Assert that the view model's properties are updated as expected
//        XCTAssertTrue(viewModel.isLoading)
//        XCTAssertNotNil(viewModel.error)
//        XCTAssertEqual(viewModel.topRated.count, 0)
//        XCTAssertEqual(viewModel.trending.count, 0)
//        XCTAssertFalse(viewModel.isLoading)
    }

    // MARK: - Test other methods...

    // Write similar test methods for other functions in the view model

}

