import SwiftUI

struct MovieDetailsView: View {
    @Environment(AppRouter.self) private var router: AppRouter
    @Bindable var viewModel: MovieDetailsViewModel
    var body: some View {
        VStack(alignment: .leading) {
            ParallaxView {
                ZStack(alignment: .topLeading) {
                    AsyncImageCache(
                        url: URL(string: viewModel.movie?.backdropURLString ?? "https://placehold.co/600x400")!,
                        imageFit: .fill,
                        progressSize: 150
                    )
                    .shimmer(active: viewModel.isLoading)

                    HStack {
                        Button(action: {
                            router.pop()
                        }, label: {
                            Image(systemName: "arrow.backward")
                                .font(.headline)
                        })
                        Text("Video Details")
                            .font(.headline)
                            .foregroundStyle(Color.onContainerAlternate)
                    }
                    .padding(.horizontal, SizeTokens.small)
                    .padding(.top, 60)
                }
                .ignoresSafeArea(.all)
            } content: {
                // Content Overlay
                VStack(alignment: .leading, spacing: SizeTokens.regular) {
                    // Movie Title
                    Text(viewModel.movie?.title ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.onContainer)
                        .shimmer(active: viewModel.isLoading)

                    // Movie Description
                    Text(viewModel.movie?.overview ?? "")
                        .foregroundColor(.onContainer)
                        .frame(width: UIScreen.main.bounds.width - SizeTokens.large)
                        .shimmer(active: viewModel.isLoading)

                    // Genres View
                    if let genres = viewModel.movie?.genres?.compactMap(\.name) {
                        GenresView(genres: genres)
                    }

                    // Star Rating View
                    StarRatingView(rating: Double(viewModel.movie?.voteAverage ?? .zero))
                        .shimmer(active: viewModel.isLoading)

                    // Language and Producers View
                    let languages = viewModel.movie?.languages
                    let producers = viewModel.movie?.productionCompanies
                    LanguageAndProducersView(
                        languages: languages?.map(\.englishName) ?? [],
                        producers: producers?.map(\.name) ?? [],
                        year: viewModel.movie?.releaseDate?.toMovieYearString ?? ""
                    )
                    .shimmer(active: viewModel.isLoading)

                    // Add more details as needed

                    Spacer()
                }
                .padding(SizeTokens.regular)
                .background(Color.container)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview(body: {
    ScrollView {
        MovieDetailsView(
            viewModel: MovieDetailsViewModel(movie: 0)
        )
        .environment(AppRouter(.landing))
    }
})
