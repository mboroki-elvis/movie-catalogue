import SwiftUI

struct TopRatedMoviesRow: View {
    let movies: [Movie]
    var isLoading: Bool
    var onTap: (Movie) -> Void
    var viewAll: () -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(with: .topRated)
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
            .padding(.trailing, SizeTokens.small)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: SizeTokens.extraSmall) {
                    if isLoading || movies.isEmpty {
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
            movies: [defaultMovie, defaultMovie],
            isLoading: false,
            onTap: { _ in }, 
            viewAll: {}
        ).aspectRatio(3 / 2, contentMode: .fit)

        TopRatedMoviesRow(
            movies: [defaultMovie, defaultMovie],
            isLoading: true,
            onTap: { _ in }, 
            viewAll: {}
        ).aspectRatio(3 / 2, contentMode: .fit)
    })
}
