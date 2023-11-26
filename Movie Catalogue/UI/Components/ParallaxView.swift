import SwiftUI

struct ParallaxView<Header, Content>: View where Content: View, Header: View {
    private let axes: Axis.Set
    private let header: () -> Header
    private let content: () -> Content
    @State private var offset: CGPoint
    @State private var height: CGFloat
    @State private var headerHeight: CGFloat
    init(
        _ axes: Axis.Set = .vertical,
        headerHeight: CGFloat = 160,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axes = axes
        self.header = header
        self.content = content
        self.offset = .zero
        self.height = headerHeight
        self.headerHeight = headerHeight
    }

    var body: some View {
        VStack {
            header()
                .frame(height: height)
            OffsetObservingScrollView(
                axes: axes,
                offset: $offset,
                content: content
            )
            .onChange(of: offset) { _, newValue in
                let proposedHeight = height + newValue.y
                if proposedHeight <= 44 {
                    height = 44
                } else if proposedHeight >= headerHeight {
                    height = headerHeight
                } else {
                    height = proposedHeight
                }
            }
        }
    }
}

#Preview {
    ParallaxView(.vertical) {
        AsyncImageCache(url: URL(string: "https://placehold.co/600x400")!)
    } content: {
        GenresView(genres: ["Action", "Sci-fi", "Fantasy"])
    }
}
