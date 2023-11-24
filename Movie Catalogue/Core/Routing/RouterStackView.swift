import SwiftUI

struct RouterStackView<V: View, T: Hashable>: View {
    @Bindable var pathInfo: PathInfo<T>
    let router: Router<T>
    let viewForRoute: (T) -> V

    init(router: Router<T>, pathInfo: PathInfo<T>? = nil, @ViewBuilder viewForRoute: @escaping (T) -> V) {
        self.router = router
        self.pathInfo = pathInfo ?? router.pathInfo
        self.viewForRoute = viewForRoute
    }

    var body: some View {
        NavigationStack(path: $pathInfo.path) {
            viewForRoute(pathInfo.root)
                .navigationDestination(for: T.self) { route in
                    viewForRoute(route)
                }
        }
        .fullScreenCover(isPresented: Binding(
            get: { pathInfo.showFullScreen },
            set: { if $0 == false { router.popTo(pathInfo) } })
        ) {
            RouterStackView(router: router, pathInfo: pathInfo.subPath!, viewForRoute: viewForRoute)
        }
        .sheet(isPresented: Binding(
            get: { pathInfo.showSheet },
            set: { if $0 == false { router.popTo(pathInfo) } })
        ) {
            RouterStackView(router: router, pathInfo: pathInfo.subPath!, viewForRoute: viewForRoute)
                .presentationDetents(pathInfo.detents)
        }
    }
}
