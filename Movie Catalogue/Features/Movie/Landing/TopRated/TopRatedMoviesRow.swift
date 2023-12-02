import SwiftUI

struct TopRatedMoviesRow: View {
    let movies: [Movie]
    var isLoading: Bool
    var onTap: (Movie) -> Void
    var viewAll: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
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
            .padding(.init(top: SizeTokens.small, leading: .zero, bottom: SizeTokens.small, trailing: SizeTokens.small))
            let actualWidth = width - SizeTokens.extraSmall
            TabView {
                if isLoading || movies.isEmpty {
                    CarouselLoadingState(
                        height: width / 2
                    )
                } else {
                    ForEach(movies) { movie in
                        TopRatedMoviesView(movie: movie)
                            .onTapGesture {
                                onTap(movie)
                            }
                    }
                }
            }
            .frame(width: actualWidth, height: actualWidth / 2)
            .tabViewStyle(PageTabViewStyle())
            .transition(.opacity)
            .animation(.easeInOut, value: isLoading)
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
