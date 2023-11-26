import SwiftUI

struct TrendingMoviesRow: View {
    let category: LocalizableKeys
    let movies: [Movie]
    var isLoading: Bool
    var onTap: (Movie) -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(with: category)
                    .font(.headline)
                    .padding(.top, SizeTokens.extraSmall)
                Spacer()
                Button(action: {}, label: {
                    Text(with: .viewAll)
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
    VStack {
        TrendingMoviesRow(
            category: .trending,
            movies: [defaultMovie],
            isLoading: false,
            onTap: { _ in }
        ).aspectRatio(3 / 2, contentMode: .fit)
        
        TrendingMoviesRow(
            category: .trending,
            movies: [defaultMovie],
            isLoading: true,
            onTap: { _ in }
        ).aspectRatio(3 / 2, contentMode: .fit)
        
    }
    .background(Color(UIColor.systemGroupedBackground))
}
