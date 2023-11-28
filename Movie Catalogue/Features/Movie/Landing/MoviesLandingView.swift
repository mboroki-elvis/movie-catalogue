import SwiftData
import SwiftUI

struct MoviesLandingView: View {
    // MARK: Properties

    @Environment(\.modelContext) private var modelContext
    @Environment(AppRouter.self) private var router: AppRouter
    @Query private var favorites: [FavoriteMovie]
    @Bindable private var viewModel = MovieLandingViewModel()

    // MARK: UI

    var body: some View {
        ContainerView(
            error: viewModel.error,
            onDismissError: {
                viewModel.error = nil
            }
        ) {
            ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    Color(UIColor.systemGroupedBackground)
                        .ignoresSafeArea(.all)

                    VStack(alignment: .center, spacing: .zero) {
                        TopRatedMoviesRow(
                            movies: viewModel.topRated,
                            isLoading: viewModel.isLoading,
                            onTap: { movie in
                                viewModel.movie = movie
                                viewModel.presentDialog = true
                            },
                            viewAll: {
                                router.push(.viewTopRated)
                            }
                        )
                        .padding(.horizontal, SizeTokens.regular)

                        TrendingMoviesRow(
                            movies: viewModel.trending,
                            isLoading: viewModel.isLoading,
                            onTap: { movie in
                                viewModel.movie = movie
                                viewModel.presentDialog = true
                            },
                            viewAll: {
                                router.push(.viewTrending)
                            }
                        )
                        .padding(.horizontal, SizeTokens.regular)

                        FavoriteMovieRow(
                            movies: favorites,
                            isLoading: viewModel.isLoading,
                            onTap: { favorite in
                                viewModel.movie = .init(favorite: favorite)
                                viewModel.presentDialog = true
                            }
                        )
                        .padding(.horizontal, SizeTokens.regular)
                    }
                    Spacer()
                }
            }
        }
        .task {
            viewModel.onAppear()
        }
        .refreshable {
            viewModel.onAppear()
        }
        .confirmationDialog(
            "",
            isPresented: $viewModel.presentDialog,
            presenting: $viewModel.movie
        ) { _ in
            let isFavorited = viewModel.isSelectedMovieFavourited(context: modelContext)
            Button(action: {
                withAnimation {
                    if isFavorited {
                        viewModel.deleteSelectedMovieFromContext(context: modelContext)
                    } else {
                        viewModel.addSelectedMovieToContext(context: modelContext)
                    }
                }
            }, label: {
                Text(with: isFavorited ? .removeFavorite : .addFavorite)
                    .foregroundStyle(.onContainer)
            })

            Button(action: {
                if let selected = viewModel.movie {
                    router.push(.details(selected))
                }
            }, label: {
                Text(with: .viewMovieDetails)
            })
        }
    }
}

#Preview {
    MoviesLandingView()
        .background(Color(UIColor.systemGroupedBackground))
        .modelContainer(for: FavoriteMovie.self, inMemory: true)
        .environment(AppRouter(.landing))
}
