import Foundation
import Observation
import SwiftUI

enum PresentationMode {
    case stack
    case fullScreen
    case sheet
    case halfSheet
}

@Observable class PathInfo<Т: Hashable> {
    var root: Т
    var path: [Т] = []
    var presentationMode: PresentationMode = .stack
    var subPath: PathInfo?
    weak var parent: PathInfo?

    var showFullScreen: Bool {
        subPath != nil && subPath!.presentationMode == .fullScreen
    }

    var showSheet: Bool {
        subPath != nil && (subPath!.presentationMode == .sheet || isHalfSheet)
    }

    var isHalfSheet: Bool {
        subPath != nil && subPath!.presentationMode == .halfSheet
    }

    var detents: Set<PresentationDetent> {
        guard showSheet else { return [] }
        if subPath!.presentationMode == .halfSheet {
            return [.medium]
        } else {
            return [.large]
        }
    }

    init(
        root: Т,
        presentationMode: PresentationMode = .stack,
        parent: PathInfo? = nil
    ) {
        self.root = root
        self.presentationMode = presentationMode
        self.parent = parent
    }
}
