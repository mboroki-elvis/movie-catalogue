import SwiftUI

struct FavoriteMovieView: View {
    let movie: Movie
    var body: some View {
        VStack(alignment: .center) {
            // Background Image
            AsyncImage(url: URL(string: movie.backdropURLString ?? "")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(8.0)
            
            HStack {
                Text(movie.title ?? "")
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(.black)
                
                // Favorite Icon
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)

            }
        }
    }
}

#Preview {
    FavoriteMovieView(movie: defaultMovie)
}
