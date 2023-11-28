import Kingfisher
import SwiftData
import SwiftUI

struct MovieDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppRouter.self) private var router: AppRouter
    @Bindable var viewModel: MovieDetailsViewModel
    var body: some View {
        ContainerView(
            error: viewModel.error,
            onDismissError: {
                viewModel.error = nil
            }
        ) {
            ParallaxView {
                header
            } content: {
                content
            }
        }
        .background(Color.container)
        .task {
            viewModel.onAppear(modelContext)
            viewModel.toggleIsFavorite(context: modelContext)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        ZStack(alignment: .topLeading) {
            KFImage(URL(string: viewModel.movie.backdropURLString ?? "https://placehold.co/600x400")!)
                .resizable()
                .frame(width: UIScreen.main.bounds.width)
                .shimmer(active: viewModel.isLoading)

            HStack {
                Button(action: {
                    router.pop()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .font(.headline)

                    Text(with: .movieDetails)
                        .font(.headline)
                        .foregroundStyle(Color.accentColor)
                })

                Spacer()

                Button {
                    viewModel.addOrDelete(from: modelContext)
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(
                            viewModel.isFavorite ? .accentColor : .onContainerAlternate
                        )
                }
            }
            .padding(.horizontal, SizeTokens.small)
            .padding(.trailing, SizeTokens.regular)
            .offset(y: 60)
        }
        .ignoresSafeArea()
        .onChange(of: viewModel.movie) { _, _ in
            viewModel.toggleIsFavorite(context: modelContext)
        }
    }

    private var content: some View {
        // Content Overlay
        VStack(alignment: .leading, spacing: SizeTokens.regular) {
            // Movie Title
            Text(viewModel.movie.title ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.onContainer)
                .shimmer(active: viewModel.isLoading)

            // Movie Description
            Text(viewModel.movie.overview ?? "")
                .foregroundColor(.onContainer)
                .frame(width: UIScreen.main.bounds.width - SizeTokens.large)
                .shimmer(active: viewModel.isLoading)

            // Genres View
            if let genres = viewModel.movie.genres?.compactMap(\.name) {
                GenresView(genres: genres)
            }

            // Star Rating View
            StarRatingView(rating: Double(viewModel.movie.voteAverage ?? .zero))
                .shimmer(active: viewModel.isLoading)

            // Language and Producers View
            let languages = viewModel.movie.languages
            let producers = viewModel.movie.productionCompanies
            LanguageAndProducersView(
                languages: languages?.map(\.englishName) ?? [],
                producers: producers?.map(\.name) ?? [],
                year: viewModel.movie.releaseDate?.toMovieYearString ?? ""
            )
            .shimmer(active: viewModel.isLoading)

            // Add more details as needed

            Spacer()
        }
        .background(Color.container)
        .padding(.horizontal, SizeTokens.regular)
    }
}

#Preview(body: {
    ScrollView {
        MovieDetailsView(
            viewModel: MovieDetailsViewModel(movie: defaultMovie)
        )
        .environment(AppRouter(.landing))
    }
})
