import Kingfisher
import SwiftUI
struct FavoriteMovieView: View {
    let movie: FavoriteMovie
    var body: some View {
        VStack(alignment: .center) {
            KFImage(URL(string: movie.backdropURLString ?? "")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
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
    FavoriteMovieView(movie: defaultFavoriteMovie)
}
