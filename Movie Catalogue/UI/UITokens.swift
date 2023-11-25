import SwiftUI

enum SpacingToken {
    static let extraSmall: CGFloat = 4
    static let small: CGFloat = 8
    static let regular: CGFloat = 16
    static let large: CGFloat = 32
}

enum ColorTokens: String {
    case onContainer
    case onContainerAlternate
    case container
    case containerAlternate

    var color: Color {
        Color(self.rawValue, bundle: .main)
    }
}
