import SwiftUI

struct StarRatingView: View {
    var rating: Double

    var body: some View {
        HStack {
            Text("Average Rating:")
                .foregroundColor(.onContainer)
                .font(.headline)
            Image(systemName: "hand.thumbsup.fill")
                .foregroundColor(.accentColor)
            Text(String(format: "%.1f", rating))
                .foregroundColor(.onContainer)
        }
    }
}
