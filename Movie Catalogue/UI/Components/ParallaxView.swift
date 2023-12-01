import Kingfisher
import SwiftUI

struct ParallaxView<Header, Content>: View where Content: View, Header: View {
    private let axes: Axis.Set
    private let header: () -> Header
    private let content: () -> Content
    private let minimumHeaderHeight: CGFloat = 44
    private let snappingThresholdMultiplier: CGFloat = 1.8
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

    private var dynamicHeaderHeight: CGFloat {
        let proposedHeight = height + offset.y
        let snappingThreshold = headerHeight * snappingThresholdMultiplier

        if proposedHeight >= snappingThreshold {
            return snappingThreshold
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
//                .offset(y: max(0, offset.y))
            OffsetObservingScrollView(
                axes: axes,
                offset: $offset,
                content: content
            )
            .onChange(of: offset) { _, _ in
                // TODO: Fix the strange flash due to animation of resizable images
                height = dynamicHeaderHeight
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
