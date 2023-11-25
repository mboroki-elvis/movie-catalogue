
import SwiftUI

struct TopRatedMoviesView: View {
    let movie: Movie
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Background Image
            AsyncImage(url: URL(string: movie.backdropURLString ?? "")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }

            // Overlay Components
            VStack(alignment: .trailing, spacing: 8.0) {
                HStack {
                    Text(movie.title ?? "")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(10.0)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(8.0)
                    
                    // Favorite Icon
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .padding(12.0)
                }
            }
            .padding()
        }.cornerRadius(8.0)
    }
}

#Preview {
    TopRatedMoviesView(movie: defaultMovie)
}
