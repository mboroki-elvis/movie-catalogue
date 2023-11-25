
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
            .cornerRadius(SpacingToken.small)
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
                    Text("Rating \(movie.voteAverage ?? .zero)")
                        .font(.caption)
                        .padding(SpacingToken.extraSmall)
                        .background(ColorTokens.containerAlternate.color)
                        .foregroundColor(ColorTokens.onContainerAlternate.color)
                        .cornerRadius(SpacingToken.extraSmall)

                    Text("Votes \((movie.voteCount ?? .zero))")
                        .font(.caption)
                        .padding(SpacingToken.extraSmall)
                        .background(ColorTokens.container.color)
                        .foregroundColor(ColorTokens.onContainer.color)
                        .cornerRadius(SpacingToken.extraSmall)
                }
            }
            .padding(.init(top: .zero, leading: .zero, bottom: .zero, trailing: SpacingToken.regular))
        }
        .background(ColorTokens.container.color)
        .cornerRadius(SpacingToken.small)
    }
}

#Preview {
    TrendingMoviesView(movie: defaultMovie)
        .background(Color(UIColor.systemGroupedBackground))
}


