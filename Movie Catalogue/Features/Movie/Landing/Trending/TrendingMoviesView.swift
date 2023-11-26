
import SwiftUI

struct TrendingMoviesView: View {
    let movie: Movie
    var body: some View {
        HStack(spacing: .zero) {
            // Leading Image
            if let url = URL(string: movie.backdropURLString ?? "") {
                AsyncImageCache(
                    url: url,
                    imageFit: .fill,
                    progressSize: 100
                )
                .frame(width: 100, height: 115)
                .cornerRadius(SizeTokens.small)
                .padding()
            } else {
               Image(systemName: "bolt.trianglebadge.exclamationmark.fill")
                    .frame(width: 100, height: 115)
                    .cornerRadius(SizeTokens.small)
                    .padding()
            }

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
                    Text(with: .rating, args: movie.voteAverage ?? .zero)
                        .font(.caption)
                        .padding(SizeTokens.extraSmall)
                        .background(.containerAlternate)
                        .foregroundColor(.onContainerAlternate)
                        .cornerRadius(SizeTokens.extraSmall)

                    Text(with: .votes, args: movie.voteCount ?? .zero)
                        .font(.caption)
                        .padding(SizeTokens.extraSmall)
                        .background(.container)
                        .foregroundColor(.onContainer)
                        .cornerRadius(SizeTokens.extraSmall)
                }
            }
            .padding(.init(
                top: SizeTokens.regular,
                leading: .zero,
                bottom: SizeTokens.regular,
                trailing: SizeTokens.regular
            ))
        }
        .background(.container)
        .cornerRadius(SizeTokens.small)
    }
}

#Preview {
    TrendingMoviesView(movie: defaultMovie)
        .background(Color(UIColor.systemGroupedBackground))
}
