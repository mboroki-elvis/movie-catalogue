import SwiftUI
import SwiftData

struct MovieDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppRouter.self) private var router: AppRouter
    @Bindable var viewModel: MovieDetailsViewModel
    var body: some View {
        VStack(alignment: .leading) {
            ContainerView(error: viewModel.error) {
                ParallaxView {
                    header
                } content: {
                    content
                }
            }
        }
        .task {
            viewModel.onAppear()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
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
                Text(with: .movieDetails)
                    .font(.headline)
                    .foregroundStyle(Color.onContainerAlternate)
                Spacer()

                Button {
                    viewModel.addOrDelete(from: modelContext)
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.accentColor)
                }
            }
            .padding(.horizontal, SizeTokens.small)
            .padding(.top, 60)
            .padding(.trailing, SizeTokens.regular)
        }
        .ignoresSafeArea(.all)
    }

    private var content: some View {
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

#Preview(body: {
    ScrollView {
        MovieDetailsView(
            viewModel: MovieDetailsViewModel(movieID: 0)
        )
        .environment(AppRouter(.landing))
    }
})
