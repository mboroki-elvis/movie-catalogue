import SwiftUI

struct FavoriteMovieRow: View {
    let movies: [FavoriteMovie]
    var isLoading: Bool
    var onTap: (FavoriteMovie) -> Void
    var body: some View {
        VStack(alignment: .leading) {
            Text(with: .favorites)
                .font(.headline)
                .padding(.top, SizeTokens.small)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: SizeTokens.small) {
                    ForEach(movies) { movie in
                        FavoriteMovieView(movie: movie)
                            .onTapGesture {
                                onTap(movie)
                            }
                    }
                    .frame(width: 150)
                    .shimmer(active: isLoading)
                }
            }
        }
    }
}

#Preview {
    VStack {
        FavoriteMovieRow(movies: [defaultFavoriteMovie], isLoading: true, onTap: { _ in })
        FavoriteMovieRow(movies: [defaultFavoriteMovie], isLoading: false, onTap: { _ in })
    }
}
