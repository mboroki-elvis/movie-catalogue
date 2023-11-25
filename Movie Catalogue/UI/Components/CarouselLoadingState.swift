import SwiftUI

struct CarouselLoadingState: View {
    var height: CGFloat = 208
    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            SkeletonLoadingItem()
        }
        .frame(height: height)
    }
}

#Preview {
    CarouselLoadingState()
}
