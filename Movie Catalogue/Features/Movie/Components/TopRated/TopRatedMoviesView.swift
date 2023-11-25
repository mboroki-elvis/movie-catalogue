
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

            VStack(alignment: .trailing, spacing: 8.0) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(movie.title ?? "")
                            .font(.headline)
                            .foregroundColor(.white)
                            + Text("\n") +
                            Text(movie.title ?? "")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(10.0)
                    .background(Color.black.opacity(0.7))
                    .clipShape(
                        .rect(
                            topLeadingRadius: .zero,
                            bottomLeadingRadius: .zero,
                            bottomTrailingRadius: 8,
                            topTrailingRadius: 8
                        )
                    )

                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(.red)
                        .padding(8.0)
                }
            }
            .overlay(
                Rectangle().fill(Color.red).frame(width: 4),
                alignment: .leading
            )
            .padding()
        }.cornerRadius(8.0)
    }
}

#Preview {
    TopRatedMoviesView(movie: defaultMovie)
}
