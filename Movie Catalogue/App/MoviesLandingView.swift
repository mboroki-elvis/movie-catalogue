import SwiftData
import SwiftUI

struct MoviesLandingView: View {
    // MARK: Properties

    @Environment(\.modelContext) private var modelContext
    @Query private var movies: [Movie]
    private var viewModel = MovieViewModel()

    // MARK: UI

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 0) {
                    TopRatedMoviesRow(
                        category: "Top Rated",
                        movies: viewModel.topRated
                    )
                    .padding(.leading, 16)
                    
                    TrendingMoviesRow(
                        category: "Trending",
                        movies: viewModel.trending,
                        onTap: { movie in
                            addItem(movie: movie)
                        }
                    )
                    .padding(.leading, 16)
                    
                    FavoriteMovieRow(
                        movies: movies
                    )
                    .padding(.leading, 16)
                }
            }
            .onAppear(perform: {
                viewModel.onAppear()
            })
        }
    }

    private func addItem(movie: Movie) {
        withAnimation {
            viewModel.addMovieToContext(movie: movie, context: modelContext)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
        }
    }
}

#Preview {
    MoviesLandingView()
        .background(Color(UIColor.systemGroupedBackground))
        .modelContainer(for: Movie.self, inMemory: true)
}
