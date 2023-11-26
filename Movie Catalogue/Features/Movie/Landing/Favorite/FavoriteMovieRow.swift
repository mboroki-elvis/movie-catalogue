import SwiftUI

struct FavoriteMovieRow: View {
    let movies: [Movie]
    var isLoading: Bool
    var onTap: (Movie) -> Void
    var body: some View {
        VStack(alignment: .leading) {
            Text(with: .favorites)
                .font(.headline)
                .padding(.top, SizeTokens.extraSmall)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: SizeTokens.small) {
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
        FavoriteMovieRow(movies: [defaultMovie], isLoading: true, onTap: { _ in })
        FavoriteMovieRow(movies: [defaultMovie], isLoading: false, onTap: { _ in })
    }
}
