//
//  File.swift
//  Movie CatalogueTests
//
//  Created by Elvis Mwenda on 26/11/2023.
//

import Foundation
import SwiftData

@testable import Movie_Catalogue

class MockFavoritesUseCase: FavoritesUseCase {
    
    func findMovieBy(id: Int, context: ModelContext) throws -> Movie_Catalogue.Movie? {
        nil
    }
    
    var isFailing: Bool = false
    func addSelectedMovieToContext(movie: Movie, context: ModelContext) throws {
        if isFailing {
            throw NSError(domain: "", code: 1)
        }

    }

    func deleteSelectedMovieFromContext(movie: Movie, context: ModelContext) throws {
        if isFailing {
            throw NSError(domain: "", code: 1)
        }

    }

    func contextHasMovie(movie: Movie, context: ModelContext) throws -> Bool {
        if isFailing {
            throw NSError(domain: "", code: 1)
        }
        return true
    }
}
