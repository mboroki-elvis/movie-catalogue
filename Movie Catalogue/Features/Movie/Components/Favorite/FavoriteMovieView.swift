import SwiftUI

struct FavoriteMovieView: View {
    let movie: Movie
    var body: some View {
        VStack(alignment: .center) {
            // Background Image
            AsyncImageCache(
                url: URL(string: movie.backdropURLString ?? "")!
            )
            .cornerRadius(SpacingToken.small)
            
            HStack {
                Text(movie.title ?? "")
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(ColorTokens.onContainer.color)
                
                // Favorite Icon
                Image(systemName: "heart.fill")
                    .foregroundColor(.accentColor)

            }
        }
    }
}

#Preview {
    FavoriteMovieView(movie: defaultMovie)
}
