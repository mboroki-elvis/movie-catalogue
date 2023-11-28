import SwiftUI

struct FavoriteMovieRow: View {
    let movies: [FavoriteMovie]
    var isLoading: Bool
    var onTap: (FavoriteMovie) -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: SizeTokens.small) {
            Text(with: .favorites)
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: SizeTokens.small) {
                    ForEach(movies) { movie in
                        FavoriteMovieView(movie: movie)
                            .onTapGesture {
                                onTap(movie)
                            }
                    }
                    .frame(idealWidth: 150, idealHeight: 150)
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
