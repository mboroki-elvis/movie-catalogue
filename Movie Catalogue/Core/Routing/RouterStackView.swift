import SwiftUI

/**
  The `RouterStackView` is responsible for rendering the current route and handling navigation actions.

  - Requires: The `Observation` module for observable functionality.

  ### Example Usage:
  ```swift
  let router = Router<MyRouteType>(.initialRoute)
  RouterStackView(router: router) { route in
      MyRouteView(route: route)
  }
 Parameters:
 router: The router managing the routes.
 pathInfo: The information about the current path.
 viewForRoute: A closure providing a view representation for a given route.
 Note: This view uses the NavigationStack for managing the navigation stack and supports presenting routes as either a full-screen cover or a sheet.
 ```
 */
struct RouterStackView<V: View, T: Hashable>: View {
    /// The bindable path information for the current route.
    @Bindable var pathInfo: PathInfo<T>
    /// The router managing the routes.
    let router: Router<T>
    /// A closure providing a view representation for a given route.
    let viewForRoute: (T) -> V
    /**
     Initializes a new RouterStackView.
     Parameters:
     router: The router managing the routes.
     pathInfo: The initial path information for the view.
     viewForRoute: A closure providing a view representation for a given route.
     */
    init(router: Router<T>, pathInfo: PathInfo<T>? = nil, @ViewBuilder viewForRoute: @escaping (T) -> V) {
        self.router = router
        self.pathInfo = pathInfo ?? router.pathInfo
        self.viewForRoute = viewForRoute
    }

    /// The body of the view.
    var body: some View {
        NavigationStack(path: $pathInfo.path) {
            // Render the current route
            viewForRoute(pathInfo.root)
                .navigationDestination(for: T.self) { route in
                    viewForRoute(route)
                }
        }
        .fullScreenCover(isPresented: Binding(
            get: { pathInfo.showFullScreen },
            set: { if $0 == false { router.popTo(pathInfo) } })
        ) {
            // Recursive call for full-screen cover
            RouterStackView(router: router, pathInfo: pathInfo.subPath!, viewForRoute: viewForRoute)
        }
        .sheet(isPresented: Binding(
            get: { pathInfo.showSheet },
            set: { if $0 == false { router.popTo(pathInfo) } })
        ) {
            // Recursive call for sheet presentation
            RouterStackView(router: router, pathInfo: pathInfo.subPath!, viewForRoute: viewForRoute)
                .presentationDetents(pathInfo.detents)
        }
    }
}
