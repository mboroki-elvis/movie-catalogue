import SwiftUI

struct SkeletonLoadingItem: View {
    private let colors: [Color]
    private let cornerRadius: CGFloat

    // MARK: - Init

     init(colors: [Color] = [.containerAlternate, .white], cornerRadius: CGFloat = 4) {
        self.colors = colors
        self.cornerRadius = cornerRadius
    }

    // MARK: - Body

    var body: some View {
        Rectangle()
            .fill(gradientFill(colors))
            .cornerRadius(cornerRadius)
            .shimmer()
    }
    
    func gradientFill(_ gradientColors: [Color]) -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: gradientColors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

struct SkeletonLoadingItem_Previews: PreviewProvider {
    static var previews: some View {
        return SkeletonLoadingItem()
    }
}
