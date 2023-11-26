import Foundation
import Observation
import SwiftUI

/**
  A data structure representing information about the navigation path.

  The `PathInfo` class holds details about the root, current path, presentation mode, and sub-path in a navigation stack.

  - Requires: The `Observation` module for observable functionality.

  - Example Usage:
  ```swift
  @Bindable var pathInfo = PathInfo<MyRouteType>(root: .initialRoute)
  ```
 */
@Observable
class PathInfo<T: Hashable> {
    /// The root of the navigation path.
    var root: T
    /// The current path in the navigation stack.
    var path: [T] = []
    /// The presentation mode for the current path.
    var presentationMode: PresentationMode = .stack
    /// The sub-path representing additional navigation details.
    var subPath: PathInfo?
    /// A weak reference to the parent path, if any.
    weak var parent: PathInfo?
    /// A Boolean value indicating whether to show the current path as a full-screen cover.
    var showFullScreen: Bool {
        subPath != nil && subPath!.presentationMode == .fullScreen
    }

    /// A Boolean value indicating whether to show the current path as a sheet.
    var showSheet: Bool {
        subPath != nil && (subPath!.presentationMode == .sheet || isHalfSheet)
    }

    /// A Boolean value indicating whether to show the current path as a half-sheet.
    var isHalfSheet: Bool {
        subPath != nil && subPath!.presentationMode == .halfSheet
    }

    /// The set of presentation detents based on the current presentation mode.
    var detents: Set<PresentationDetent> {
        guard showSheet else { return [] }
        if subPath!.presentationMode == .halfSheet {
            return [.medium]
        } else {
            return [.large]
        }
    }

    /**
     Initializes a new PathInfo with the specified root, presentation mode, and parent.
     Parameters:
     root: The root of the navigation path.
     presentationMode: The presentation mode for the current path.
     parent: The parent path, if any.
     */
    init(
        root: T,
        presentationMode: PresentationMode = .stack,
        parent: PathInfo? = nil
    ) {
        self.root = root
        self.presentationMode = presentationMode
        self.parent = parent
    }
}

enum PresentationMode {
    case stack
    case fullScreen
    case sheet
    case halfSheet
}
