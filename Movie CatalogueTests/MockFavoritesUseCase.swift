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
    var movie: Movie?
    
    func addSelectedMovieToContext(context: ModelContext) throws {
        if movie == nil {
            throw NSError(domain: "", code: 1)
        }
    }
    
    func deleteSelectedMovieFromContext(context: ModelContext) throws {
        if movie == nil {
            throw NSError(domain: "", code: 1)
        }
    }
    
    func contextHasMovie(context: ModelContext) throws -> Bool {
        if movie == nil {
            throw NSError(domain: "", code: 1)
        }
        return true
    }
}
