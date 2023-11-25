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

                VStack(alignment: .center, spacing: 0) {
                    TopRatedMoviesRow(
                        category: "Top Rated",
                        movies: viewModel.topRated,
                        isLoading: viewModel.isLoading,
                        onTap: { movie in
                            viewModel.currentSelectedMovie = movie
                            viewModel.presentDialog.toggle()
                        }
                    )
                    .padding(.leading, 16)

                    TrendingMoviesRow(
                        category: "Trending",
                        movies: viewModel.trending,
                        isLoading: viewModel.isLoading,
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
                Spacer()
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

            Button(action: {
                if let selected = viewModel.currentSelectedMovie {
                    print("go to \(selected.title ?? "")")
                }
            }, label: {
                HStack {
                    Text("View Movie Details")
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
