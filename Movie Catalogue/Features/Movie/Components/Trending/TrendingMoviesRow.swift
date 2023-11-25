import SwiftUI

struct TrendingMoviesRow: View {
    let category: String
    let movies: [Movie]
    var onTap: (Movie) -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category)
                    .font(.headline)
                    .padding(.top, SpacingToken.extraSmall)
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
            .padding(.init(top: SpacingToken.small, leading: .zero, bottom: .zero, trailing: SpacingToken.small))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: SpacingToken.small) {
                    ForEach(movies) { movie in
                        TrendingMoviesView(movie: movie)
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
    TrendingMoviesRow(category: "Trending", movies: [defaultMovie], onTap: { _ in })
        .background(Color(UIColor.systemGroupedBackground))
}
