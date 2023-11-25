
import SwiftUI

struct TopRatedMoviesView: View {
    let movie: Movie
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImageCache(
                url: URL(string: movie.backdropURLString ?? "")!
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure(let error):
                    Text("Something went wrong")
                @unknown default:
                    fatalError()
                }
            }

            VStack(alignment: .trailing, spacing: SpacingToken.small) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(movie.title ?? "")
                            .font(.headline)
                            .foregroundColor(ColorTokens.onContainerAlternate.color)
                            + Text("\n") +
                        Text("Popularity \(movie.popularity?.roundedInt ?? .zero)")
                            .font(.caption)
                            .foregroundColor(ColorTokens.onContainerAlternate.color)
                    }
                    .padding(SpacingToken.small)
                    .background(ColorTokens.containerAlternate.color.opacity(0.8))
                    .clipShape(
                        .rect(
                            topLeadingRadius: .zero,
                            bottomLeadingRadius: .zero,
                            bottomTrailingRadius: SpacingToken.small,
                            topTrailingRadius: SpacingToken.small
                        )
                    )

                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(.accentColor)
                        .padding(SpacingToken.small)
                }
            }
            .overlay(
                Rectangle().fill(Color.accentColor).frame(width: 4),
                alignment: .leading
            )
            .padding()
        }.cornerRadius(SpacingToken.small)
    }
}

#Preview {
    TopRatedMoviesView(movie: defaultMovie)
}
