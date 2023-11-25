import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    @Bindable var viewModel: MovieDetailsViewModel
    var body: some View {
        VStack {
            // Background Banner Image
            AsyncImageCache(
                url: URL(string: movie.backdropURLString ?? "")!,
                imageFit: .fill,
                progressSize: 150
            )
            .cornerRadius(SizeTokens.small)
            
            // Content Overlay
            VStack(alignment: .leading, spacing: 20) {
                // Movie Title
                Text(movie.title ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.onContainer)
                
                // Movie Description
                Text(movie.overview ?? "")
                    .foregroundColor(.onContainer)
                    .frame(width: UIScreen.main.bounds.width - SizeTokens.large)
                
                // Genres View
                if let genres = movie.genres?.compactMap(\.name) {
                    GenresView(genres: genres)
                }

                
                // Star Rating View
                StarRatingView(rating: 4.5)
                
                // Language and Producers View
                LanguageAndProducersView(
                    languages: ["English", "Spanish"],
                    producers: ["Producer 1", "Producer 2"]
                )
                
                // Add more details as needed
                
                Spacer()
            }
            .padding(20)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct GenresView: View {
    var genres: [String]

    var body: some View {
        HStack {
            Text("Genres:")
                .foregroundColor(.onContainer)
                .font(.headline)
            ForEach(genres, id: \.self) { genre in
                Text(genre)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
    }
}

struct StarRatingView: View {
    var rating: Double

    var body: some View {
        HStack {
            Text("Rating:")
                .foregroundColor(.onContainer)
                .font(.headline)
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text(String(format: "%.1f", rating))
                .foregroundColor(.onContainer)
        }
    }
}

struct LanguageAndProducersView: View {
    var languages: [String]
    var producers: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Languages:")
                .foregroundColor(.onContainer)
                .font(.headline)
            ForEach(languages, id: \.self) { language in
                Text(language)
                    .foregroundColor(.onContainer)
            }

            Text("Producers:")
                .foregroundColor(.onContainer)
                .font(.headline)
            ForEach(producers, id: \.self) { producer in
                Text(producer)
                    .foregroundColor(.onContainer)
            }
        }
    }
}

#Preview(body: {
    ScrollView {
        MovieDetailsView(
            movie: defaultMovie,
            viewModel: MovieDetailsViewModel(movie: 0)
        )
    }
})
