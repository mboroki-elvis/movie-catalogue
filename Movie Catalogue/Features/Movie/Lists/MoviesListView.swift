import SwiftUI
import SwiftData

struct MoviesListView: View {
    @Environment(AppRouter.self) private var router: AppRouter
    @Query private var favorites: [Movie]
    var viewModel: MovieListViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(alignment: .top) {
                Button(action: {
                    router.pop()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .font(.headline)
                    
                    Text(with: .viewAll)
                        .font(.headline)
                        .foregroundStyle(Color.onContainer)
                })
            }
            .padding(.horizontal, SizeTokens.regular)
            .padding(.vertical, SizeTokens.extraSmall)
            
            List {
                ForEach(viewModel.movies) { movie in
                    TrendingMoviesView(movie: movie)
                        .onAppear {
                            if movie == viewModel.movies.last {
                                viewModel.currentPage += 1
                                viewModel.fetchData(favorites: favorites)
                            }
                        }.onTapGesture {
                            router.push(.details(movie))
                        }
                }
                if viewModel.currentPage < viewModel.totalPages {
                    ProgressView()
                        .foregroundStyle(.accent)
                }
            }
            Spacer()
        }
        .task {
            viewModel.fetchData(favorites: favorites)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}
