//
//  MovieDetailsCoordinator.swift
//  Movie Catalogue
//
//  Created by Elvis Mwenda on 25/11/2023.
//

import SwiftUI

enum Routes: Hashable {
    case landing
    case details
    case viewAll
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
            case .details:
                MoviesLandingView()
            case .viewAll:
                Text("Hello world!")
            }
        }
    }
}
