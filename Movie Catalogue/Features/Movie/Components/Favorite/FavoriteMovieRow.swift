import SwiftUI

struct FavoriteMovieRow: View {
    let movies: [Movie]
    let category: String = "Favorites"
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.headline)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 8) {
                    ForEach(movies) { movie in
                        FavoriteMovieView(movie: movie)
                    }
                    .frame(width: 150)
                }
            }
        }
    }
}

#Preview {
    FavoriteMovieRow(movies: [defaultMovie])
}
