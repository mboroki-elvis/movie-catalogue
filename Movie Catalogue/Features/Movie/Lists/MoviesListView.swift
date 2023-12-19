import SwiftUI
import SwiftData

struct MoviesListView: View {
    @Environment(AppRouter.self) private var router: AppRouter
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
            
            ContainerView(error: viewModel.error) {
                viewModel.error = nil
            } content: {
                List {
                    ForEach(viewModel.movies) { movie in
                        TrendingMoviesView(movie: movie)
                            .onAppear {
                                if movie == viewModel.movies.last {
                                    viewModel.currentPage += 1
                                    viewModel.fetchData()
                                }
                            }.onTapGesture {
                                router.push(.details(movie))
                            }
                    }
                }
                .listStyle(PlainListStyle())
                if viewModel.currentPage < viewModel.totalPages {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .foregroundStyle(.accent)
                }
            }

            Spacer()
        }
        .background(Color.container)
        .task {
            viewModel.fetchData()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}
