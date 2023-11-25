import SwiftUI

struct TopRatedMoviesRow: View {
    let category: String
    let movies: [Movie]
    var isLoading: Bool
    var onTap: (Movie) -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category)
                    .font(.headline)
                    .padding(.top, 5)
                Spacer()
                Button(action: {}, label: {
                    Text("View All")
                        .foregroundStyle(.onContainerAlternate)
                        .padding(.horizontal, SizeTokens.small)
                        .background(
                            RoundedRectangle(cornerRadius: SizeTokens.small)
                                .fill(.containerAlternate)
                        )
                })
            }
            .padding(.trailing, SizeTokens.small)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: SizeTokens.small) {
                    if isLoading {
                        ForEach(0 ..< 4, id: \.self) { _ in
                            CarouselLoadingState().frame(width: width)
                        }
                    } else {
                        ForEach(movies) { movie in
                            TopRatedMoviesView(movie: movie)
                                .onTapGesture {
                                    onTap(movie)
                                }
                        }.frame(width: width)
                    }
                }
            }
            .scrollTargetBehavior(.paging)
        }
    }

    private let width = UIScreen.main.bounds.width - SizeTokens.large
}

#Preview {
    VStack(content: {
        TopRatedMoviesRow(
            category: "Top Rated",
            movies: [defaultMovie, defaultMovie],
            isLoading: false,
            onTap: { _ in }
        ).aspectRatio(3 / 2, contentMode: .fit)

        TopRatedMoviesRow(
            category: "Top Rated",
            movies: [defaultMovie, defaultMovie],
            isLoading: true,
            onTap: { _ in }
        ).aspectRatio(3 / 2, contentMode: .fit)
    })
}
