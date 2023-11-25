import SwiftData
import SwiftUI

struct MoviesLandingView: View {
    // MARK: Properties

    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [Movie]
    @Bindable private var viewModel = MovieViewModel()

    // MARK: UI

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading, spacing: 0) {
                    TopRatedMoviesRow(
                        category: "Top Rated",
                        movies: viewModel.topRated,
                        onTap: { movie in
                            viewModel.currentSelectedMovie = movie
                            viewModel.presentDialog.toggle()
                        }
                    )
                    .padding(.leading, 16)

                    TrendingMoviesRow(
                        category: "Trending",
                        movies: viewModel.trending,
                        onTap: { movie in
                            viewModel.currentSelectedMovie = movie
                            viewModel.presentDialog.toggle()
                        }
                    )
                    .padding(.leading, 16)

                    FavoriteMovieRow(
                        movies: favorites, 
                        onTap: { movie in
                            viewModel.currentSelectedMovie = movie
                            viewModel.presentDialog.toggle()
                        }
                    )
                    .padding(.leading, 16)
                }
            }
            .onAppear(perform: {
                viewModel.onAppear()
            })
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
                    Text(isFavorited ? "Remove favorite" : "Add favorite")
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
}
