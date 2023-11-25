import SwiftUI

struct TopRatedMoviesRow: View {
    let category: String
    let movies: [Movie]
    var onTap: (Movie) -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category)
                    .font(.headline)
                    .padding(.top, 5)
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("View All")
                        .foregroundStyle(ColorTokens.onContainerAlternate.color)
                        .padding(.horizontal, SpacingToken.small)
                        .background(
                            RoundedRectangle(cornerRadius: SpacingToken.small)
                                .fill(ColorTokens.containerAlternate.color)
                        )
                })
            }
            .padding(.trailing, SpacingToken.small)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: SpacingToken.small) {
                    ForEach(movies) { movie in
                        TopRatedMoviesView(movie: movie)
                            .onTapGesture {
                                onTap(movie)
                            }
                    }.frame(width: UIScreen.main.bounds.width - SpacingToken.large)
                }
            }
        }
    }
}

#Preview {
    TopRatedMoviesRow(
        category: "Top Rated",
        movies: [defaultMovie, defaultMovie],
        onTap: { _ in }
    )
}
