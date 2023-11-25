
import SwiftUI

struct TrendingMoviesView: View {
    let movie: Movie
    var body: some View {
        HStack(spacing: 0) {
            // Leading Image
            AsyncImage(url: URL(string: movie.backdropURLString ?? "")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 115)
            .foregroundColor(.blue)
            .cornerRadius(8)
            .padding()

            VStack(alignment: .leading) {
                // Title
                Text(movie.title ?? "")
                    .font(.headline)

                // Subtitle
                Text(movie.overview ?? "")
                    .font(.subheadline)
                    .lineLimit(3)
                    .truncationMode(.tail)
                    .foregroundColor(.gray)

                // Category Labels
                HStack {
                    Text("Votes \(movie.voteCount ?? .zero)")
                        .font(.caption)
                        .padding(5)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(5)

                    Text("Rating \((movie.voteAverage ?? .zero))")
                        .font(.caption)
                        .padding(5)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            .padding(.init(top: .zero, leading: .zero, bottom: .zero, trailing: 16))
        }
        .background(.white)
        .cornerRadius(8)
    }
}

#Preview {
    TrendingMoviesView(movie: defaultMovie)
        .background(Color(UIColor.systemGroupedBackground))
}


