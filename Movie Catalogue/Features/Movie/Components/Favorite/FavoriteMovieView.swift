import SwiftUI

struct FavoriteMovieView: View {
    let movie: Movie
    var body: some View {
        VStack(alignment: .center) {
            AsyncImageCache(
                url: URL(string: movie.backdropURLString ?? "")!,
                progressSize: 150
            )
            .cornerRadius(SizeTokens.small)
            
            HStack {
                Text(movie.title ?? "")
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(.onContainer)
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.accentColor)

            }
        }
    }
}

#Preview {
    FavoriteMovieView(movie: defaultMovie)
}
