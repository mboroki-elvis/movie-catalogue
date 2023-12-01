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
    var isFailing: Bool
    init(isFailing: Bool) {
        self.isFailing = isFailing
    }
    func addRelatedModels(
        genres: [GenreResponse]?,
        collection: CollectionResponse?,
        companies: [CompanyResponse]?,
        languages: [LanguageResponse]?,
        to favourite: Movie_Catalogue.FavoriteMovie,
        in context: ModelContext
    ) {
        
    }
    
    func fetchAllFavorites(context: ModelContext) throws -> [FavoriteMovie] {
        isFailing ? [] : [defaultFavoriteMovie]
    }
    
    
    func findMovieBy(id: Int, context: ModelContext) throws -> FavoriteMovie? {
        if isFailing {
           return nil
        }
        return defaultFavoriteMovie
    }
    
    func addSelectedMovieToContext(movie: FavoriteMovie, context: ModelContext) throws {
        if isFailing {
            throw NSError(domain: "", code: 1)
        }

    }

    func deleteSelectedMovieFromContext(movie: FavoriteMovie, context: ModelContext) throws {
        if isFailing {
            throw NSError(domain: "", code: 1)
        }

    }

    func contextHasMovie(movie: FavoriteMovie, context: ModelContext) throws -> Bool {
        if isFailing {
            throw NSError(domain: "", code: 1)
        }
        return true
    }
}
