import SwiftUI

struct MoviesListView: View {
    var viewModel: MovieListViewModel
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.movies) { movie in
                    // Display your data here
                    Text(movie.title ?? "")
                }
                if viewModel.currentPage < viewModel.totalPages {
                    ProgressView()
                        .onAppear {
                            // Load more data when the last item is displayed
                            viewModel.currentPage += 1
                            viewModel.fetchData()
                        }
                }
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}
