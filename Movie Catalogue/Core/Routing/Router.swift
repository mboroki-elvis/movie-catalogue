import Foundation
import Observation

/**
 A router for managing navigation within an application.

 The router maintains a stack of routes and provides methods for pushing, popping, and navigating through the routes.

 - Note: This class is designed to be used with the `@Observable` property wrapper.

 - Requires: The `Observation` module for observable functionality.

 ### Example Usage:
 ```swift
 @Bindable var myRouter = Router<MyRouteType>(.initialRoute)
 ```
 **/

@Observable
class Router<T: Hashable> {
    /// The information about the current path.
    var pathInfo: PathInfo<T>
    /// The weak reference to the top path information in the stack.
    private weak var topPathInfo: PathInfo<T>?
    /// The current active route in the stack.
    var currentRoute: T {
        let info: PathInfo = topPathInfo ?? pathInfo
        if info.path.count > 0 {
            return info.path.last!
        }
        return info.root
    }

    /**
     Initializes a new router with the specified initial route.
     Parameter root: The initial route for the router.
     */
    init(_ root: T) {
        self.pathInfo = PathInfo(root: root)
        self.topPathInfo = pathInfo
    }

    /**
     Pushes a new route onto the stack.
     Parameters:
     route: The route to append to the stack.
     presentationMode: Defines the presentation mode for the route.
     Note: This method is asynchronous and should be called on the main thread.
     */
    func push(_ route: T, presentationMode: PresentationMode = .stack) {
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

    /**
     Pops the top route from the stack.
     Note: This method is asynchronous and should be called on the main thread.
     */
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

    /**
     Pops routes from the stack until the specified path information is reached.
     Parameter pathInfo: The target path information to pop routes up to.
     Note: This method is asynchronous and should be called on the main thread.
     */
    func popTo(_ pathInfo: PathInfo<T>) {
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
