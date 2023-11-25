
import SwiftUI

struct TopRatedMoviesView: View {
    let movie: Movie
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImageCache(
                url: URL(string: movie.backdropURLString ?? "")!,
                imageFit: .fill
            )
            VStack(alignment: .trailing, spacing: SizeTokens.small) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(movie.title ?? "")
                            .font(.headline)
                            .foregroundColor(.onContainerAlternate)
                            + Text("\n") +
                        Text("Popularity \(movie.popularity?.roundedInt ?? .zero)")
                            .font(.caption)
                            .foregroundColor(.onContainerAlternate)
                    }
                    .padding(SizeTokens.small)
                    .background(.containerAlternate.opacity(0.8))
                    .clipShape(
                        .rect(
                            topLeadingRadius: .zero,
                            bottomLeadingRadius: .zero,
                            bottomTrailingRadius: SizeTokens.small,
                            topTrailingRadius: SizeTokens.small
                        )
                    )

                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(.accentColor)
                        .padding(SizeTokens.small)
                }
            }
            .overlay(
                Rectangle().fill(Color.accentColor).frame(width: 4),
                alignment: .leading
            )
            .padding()
        }.cornerRadius(SizeTokens.small)
    }
}

#Preview {
    TopRatedMoviesView(movie: defaultMovie)
}
