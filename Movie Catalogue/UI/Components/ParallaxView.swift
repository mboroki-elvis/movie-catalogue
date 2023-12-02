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

    private var snappingThreshold: CGFloat { headerHeight * snappingThresholdMultiplier }
    private var dynamicHeaderHeight: CGFloat {
        let proposedHeight = height + offset.y
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
                .scaleEffect(y: height >= snappingThreshold ? scale : 1.0, anchor: .zero)
            OffsetObservingScrollView(
                axes: axes,
                offset: $offset,
                content: content
            )
            .onChange(of: offset) { oldValue, newValue in
                height = dynamicHeaderHeight
                scale += (newValue.y - oldValue.y) / height
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
