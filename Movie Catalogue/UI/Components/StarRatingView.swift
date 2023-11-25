import SwiftUI

struct StarRatingView: View {
    var rating: Double

    var body: some View {
        HStack {
            Text("Rating:")
                .foregroundColor(.onContainer)
                .font(.headline)
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text(String(format: "%.1f", rating))
                .foregroundColor(.onContainer)
        }
    }
}
