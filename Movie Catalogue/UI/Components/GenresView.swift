import SwiftUI

struct GenresView: View {
    var genres: [String]

    var body: some View {
        HStack {
            Text("Genres:")
                .foregroundColor(.onContainer)
                .font(.headline)
            ForEach(genres, id: \.self) { genre in
                Text(genre)
                    .font(.caption)
                    .padding(SizeTokens.extraSmall)
                    .background(.containerAlternate)
                    .foregroundColor(.onContainerAlternate)
                    .cornerRadius(SizeTokens.extraSmall)
            }
        }
    }
}
