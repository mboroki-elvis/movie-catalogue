import SwiftUI

struct SkeletonLoadingItem: View {
    private let colors: [Color]
    private let cornerRadius: CGFloat

    // MARK: - Init

    init(colors: [Color] = [.containerAlternate.opacity(0.6), .white], cornerRadius: CGFloat = 4) {
        self.colors = colors
        self.cornerRadius = cornerRadius
    }

    // MARK: - Body

    var body: some View {
        Rectangle()
            .fill(gradientFill(colors))
            .cornerRadius(cornerRadius)
            .shimmering(active: true)
    }
    
    func gradientFill(_ gradientColors: [Color]) -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: gradientColors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    SkeletonLoadingItem()
}
