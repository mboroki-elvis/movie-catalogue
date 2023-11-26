//
//  MovieDetailsCoordinator.swift
//  Movie Catalogue
//
//  Created by Elvis Mwenda on 25/11/2023.
//

import SwiftUI

enum Routes: Hashable {
    case landing
    case details(Int)
    case viewTrending
    case viewTopRated
}

typealias AppRouter = Router<Routes>

struct AppCoordinator: View {
    @Environment(AppRouter.self) private var router: AppRouter

    // MARK: - UI

    var body: some View {
        RouterStackView(router: router, viewForRoute: viewForRoute)
    }

    @ViewBuilder private func viewForRoute(_ route: Routes) -> some View {
        Group {
            switch route {
            case .landing:
                MoviesLandingView()
            case .details(let id):
                MovieDetailsView(viewModel: .init(movieID: id))
            case .viewTrending:
                MoviesListView(viewModel: .init(list: .trending))
            case  .viewTopRated:
                MoviesListView(viewModel: .init(list: .topRated))
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}
