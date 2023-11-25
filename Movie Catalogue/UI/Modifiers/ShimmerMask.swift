import SwiftUI

struct ShimmerMask: AnimatableModifier {
    var location: CGFloat = 0
    let centerColor = Color.black
    let edgeColor = Color.black.opacity(0.3)
    let step = 0.2
    let scale = 3.0

    var animatableData: CGFloat {
        get { location }
        set { location = newValue }
    }

    func body(content: Content) -> some View {
        content
            .mask(
                LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: edgeColor, location: location - step),
                            .init(color: centerColor, location: location),
                            .init(color: edgeColor, location: location + step),
                        ]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .scaleEffect(scale)
            )
    }
}
