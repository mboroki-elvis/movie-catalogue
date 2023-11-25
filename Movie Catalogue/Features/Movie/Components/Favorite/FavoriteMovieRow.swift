import SwiftUI

struct FavoriteMovieRow: View {
    let movies: [Movie]
    var onTap: (Movie) -> Void
    let category: String = "Favorites"
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.headline)
                .padding(.top, SpacingToken.extraSmall)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: SpacingToken.small) {
                    ForEach(movies) { movie in
                        FavoriteMovieView(movie: movie)
                            .onTapGesture {
                                onTap(movie)
                            }
                    }
                    .frame(width: 150)
                }
            }
        }
    }
}

#Preview {
    FavoriteMovieRow(movies: [defaultMovie], onTap: { _ in })
}
