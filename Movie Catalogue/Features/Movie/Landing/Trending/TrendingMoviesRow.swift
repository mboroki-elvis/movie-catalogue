import SwiftUI

struct TrendingMoviesRow: View {
    let movies: [Movie]
    var isLoading: Bool
    var onTap: (Movie) -> Void
    var viewAll: () -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(with: .trending)
                    .font(.headline)
                    .padding(.top, SizeTokens.extraSmall)
                Spacer()
                Button(action: viewAll, label: {
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
                HStack(alignment: .top, spacing: SizeTokens.extraSmall) {
                    let actualWidth = width - SizeTokens.extraSmall
                    if isLoading || movies.isEmpty {
                        ForEach(0 ..< 4, id: \.self) { _ in
                            CarouselLoadingState(
                                height: actualWidth / 2
                            ).frame(width: actualWidth)
                        }
                    } else {
                        ForEach(movies) { movie in
                            TrendingMoviesView(movie: movie)
                                .onTapGesture {
                                    onTap(movie)
                                }
                        }.frame(width: actualWidth, height: actualWidth / 2)
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
            movies: [defaultMovie],
            isLoading: false,
            onTap: { _ in }, 
            viewAll: {}
        ).aspectRatio(3 / 2, contentMode: .fit)
        
        TrendingMoviesRow(
            movies: [defaultMovie],
            isLoading: true,
            onTap: { _ in }, 
            viewAll: {}
        ).aspectRatio(3 / 2, contentMode: .fit)
        
    }
    .background(Color(UIColor.systemGroupedBackground))
}
