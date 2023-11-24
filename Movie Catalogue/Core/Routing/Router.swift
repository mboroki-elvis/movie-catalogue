import Foundation
import Observation

@Observable class Router<Т: Hashable> {
    var pathInfo: PathInfo<Т>
    private weak var topPathInfo: PathInfo<Т>?

    var currentRoute: Т {
        let info: PathInfo = topPathInfo ?? pathInfo
        if info.path.count > 0 {
            return info.path.last!
        }
        return info.root
    }

    /// Initialises a new router
    ///
    /// - Parameters:
    ///   - root: The initial route
    ///
    init(_ root: Т) {
        self.pathInfo = PathInfo(root: root)
        self.topPathInfo = pathInfo
    }

    /// A method used to push a new route to the stack
    ///
    /// - Parameters:
    ///   - route: the route to append
    ///   - presentationMode: Defines the presentation mode. It can be one of the following:
    ///     - stack - this is the default option, presents the route as in NavigationStack
    ///     - sheet - presents the route in a sheet
    ///     - fullScreen - uses fullScreenCover to present the route
    ///
    func push(_ route: Т, presentationMode: PresentationMode = .stack) {
        DispatchQueue.main.async {
            if presentationMode == .stack {
                self.topPathInfo?.path.append(route)
            } else {
                let newPathInfo = PathInfo(
                    root: route,
                    presentationMode: presentationMode,
                    parent: self.topPathInfo
                )
                self.topPathInfo?.subPath = newPathInfo
                self.topPathInfo = newPathInfo
            }
        }
    }

    /// Pops the top route from the stack
    ///
    func pop() {
        DispatchQueue.main.async {
            if self.topPathInfo != nil, self.topPathInfo!.path.count > 0 {
                self.topPathInfo?.path.removeLast()
            } else if self.topPathInfo?.parent != nil {
                self.topPathInfo = self.topPathInfo?.parent
                self.topPathInfo?.subPath = nil
            }
        }
    }

    /// This method is used internally by the VBRouterView class
    ///
    func popTo(_ pathInfo: PathInfo<Т>) {
        DispatchQueue.main.async {
            var current = self.topPathInfo
            while current != nil {
                if current === pathInfo {
                    self.topPathInfo = current
                    self.topPathInfo?.subPath = nil
                    return
                }
                current = current?.parent
            }
        }
    }
}
