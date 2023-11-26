import SwiftData
import SwiftUI

struct MoviesLandingView: View {
    // MARK: Properties

    @Environment(\.modelContext) private var modelContext
    @Environment(AppRouter.self) private var router: AppRouter
    @Query private var favorites: [Movie]
    @Bindable private var viewModel = MovieLandingViewModel()

    // MARK: UI

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)

                VStack(alignment: .center, spacing: .zero) {
                    TopRatedMoviesRow(
                        category: .topRated,
                        movies: viewModel.topRated,
                        isLoading: viewModel.isLoading,
                        onTap: { movie in
                            viewModel.currentSelectedMovie = movie
                            viewModel.presentDialog.toggle()
                        }
                    )
                    .padding(.horizontal, SizeTokens.regular)

                    TrendingMoviesRow(
                        category: .trending,
                        movies: viewModel.trending,
                        isLoading: viewModel.isLoading,
                        onTap: { movie in
                            viewModel.currentSelectedMovie = movie
                            viewModel.presentDialog.toggle()
                        }
                    )
                    .padding(.horizontal, SizeTokens.regular)

                    FavoriteMovieRow(
                        movies: favorites, 
                        isLoading: viewModel.isLoading,
                        onTap: { movie in
                            viewModel.currentSelectedMovie = movie
                            viewModel.presentDialog.toggle()
                        }
                    )
                    .padding(.horizontal, SizeTokens.regular)
                }
                Spacer()
            }.task {
                viewModel.onAppear()
            }
        }.confirmationDialog("", isPresented: $viewModel.presentDialog) {
            let isFavorited = viewModel.isSelectedMovieFavourited(movies: favorites)
            Button(action: {
                if isFavorited {
                    viewModel.deleteSelectedMovieFromContext(context: modelContext)
                } else {
                    viewModel.addSelectedMovieToContext(context: modelContext)
                }
            }, label: {
                HStack {
                    Text(with: isFavorited ? .removeFavorite : .addFavorite)
                }
            })

            Button(action: {
                if let selected = viewModel.currentSelectedMovie {
                    router.push(.details(selected.id))
                }
            }, label: {
                HStack {
                    Text(with: .viewMovieDetails)
                }
            })
        }
    }

    private func addItem(movie: Movie) {
        withAnimation {
            viewModel.addSelectedMovieToContext(context: modelContext)
        }
    }

    private func deleteItems(movie: Movie) {
        withAnimation {
            viewModel.deleteSelectedMovieFromContext(context: modelContext)
        }
    }
}

#Preview {
    MoviesLandingView()
        .background(Color(UIColor.systemGroupedBackground))
        .modelContainer(for: Movie.self, inMemory: true)
        .environment(AppRouter(.landing))
}
