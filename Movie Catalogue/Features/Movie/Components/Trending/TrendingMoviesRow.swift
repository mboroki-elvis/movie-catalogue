import SwiftUI

struct TrendingMoviesRow: View {
    let category: String
    let movies: [Movie]
    var isLoading: Bool
    var onTap: (Movie) -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category)
                    .font(.headline)
                    .padding(.top, SizeTokens.extraSmall)
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
            .padding(.init(top: SizeTokens.small, leading: .zero, bottom: .zero, trailing: SizeTokens.small))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: SizeTokens.small) {
                    if isLoading {
                        ForEach(0 ..< 4, id: \.self) { _ in
                            CarouselLoadingState(height: 130).frame(width: width)
                        }
                    } else {
                        ForEach(movies) { movie in
                            TrendingMoviesView(movie: movie)
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
    TrendingMoviesRow(
        category: "Trending",
        movies: [defaultMovie],
        isLoading: true,
        onTap: { _ in }
    )
    .background(Color(UIColor.systemGroupedBackground))
}
