import SwiftUI

struct TopRatedMoviesRow: View {
    let category: String
    let movies: [Movie]
    var onTap: (Movie) -> Void
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.headline)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 8) {
                    ForEach(movies) { movie in
                        TopRatedMoviesView(movie: movie)
                            .onTapGesture {
                                onTap(movie)
                            }
                    }.frame(width: UIScreen.main.bounds.width - 32.0)
                }
            }
        }
    }
}

#Preview {
    TopRatedMoviesRow(
        category: "Top Rated",
        movies: [defaultMovie, defaultMovie],
        onTap: { _ in }
    )
}
