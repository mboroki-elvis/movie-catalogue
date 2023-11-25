import SwiftUI

struct Shimmer: ViewModifier {
    let animation: Animation
    @State private var location: CGFloat = 0

    static let defaultAnimation = Animation
        .linear(duration: 1.5)
        .repeatForever(autoreverses: false)

    init(animation: Animation = Shimmer.defaultAnimation) {
        self.animation = animation
    }

    func body(content: Content) -> some View {
        content
            .modifier(ShimmerMask(location: location).animation(animation))
            .onAppear { location = 0.8 }
    }
}

extension View {
    @ViewBuilder func shimmer(
        active: Bool = true,
        animation: Animation = Shimmer.defaultAnimation
    ) -> some View {
        if active {
            modifier(Shimmer(animation: animation))
        } else {
            self
        }
    }
}
