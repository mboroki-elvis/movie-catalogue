import Kingfisher
import SwiftUI

struct ParallaxView<Header, Content>: View where Content: View, Header: View {
    private let axes: Axis.Set
    private let header: () -> Header
    private let content: () -> Content
    private let minimumHeaderHeight: CGFloat = 44
    @State private var offset: CGPoint
    @State private var height: CGFloat
    @State private var headerHeight: CGFloat
    @State private var scale: CGFloat = 1
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

    private var dynamicHeaderHeight: CGFloat {
        let proposedHeight = height + offset.y
        if proposedHeight >= headerHeight {
            return headerHeight
        } else if proposedHeight <= minimumHeaderHeight {
            return minimumHeaderHeight
        } else {
            return proposedHeight
        }
    }

    var body: some View {
        VStack(spacing: .zero) {
            header()
                .frame(height: height)
                .scaleEffect(y: scale, anchor: .zero)
            OffsetObservingScrollView(
                axes: axes,
                offset: $offset,
                content: content
            )
            .onChange(of: offset) { oldValue, newValue in
                height = dynamicHeaderHeight
                if height < headerHeight {
                    scale = 1.0
                } else {
                    scale += (newValue.y - oldValue.y) / height
                }
            }
        }
    }
}

#Preview {
    ParallaxView(.vertical) {
        KFImage(URL(string: "https://placehold.co/600x400")!)
    } content: {
        GenresView(genres: ["Action", "Sci-fi", "Fantasy"])
    }
}
