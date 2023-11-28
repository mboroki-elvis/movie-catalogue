import SwiftUI

struct ContainerView<Content: View>: View {
    var error: LocalizedError?
    var onDismissError: () -> Void
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(spacing: .zero) {
            if let error {
                HStack {
                    VStack(alignment: .leading) {
                        Text(with: .error)
                            .lineLimit(2)
                            .font(.title3)
                        Text(error.errorDescription ?? error.localizedDescription)
                            .lineLimit(2)
                            .font(.caption)
                    }
                    .padding()

                    Spacer()

                    Button {
                        onDismissError()
                    } label: {
                        Image(systemName: "x.circle")
                            .font(.title)
                            .foregroundStyle(Color.onContainer)
                    }
                    .padding(.trailing)
                }
                .background(.accent.opacity(0.7))
                .clipShape(
                    .rect(
                        topLeadingRadius: SizeTokens.small,
                        bottomLeadingRadius: SizeTokens.small,
                        bottomTrailingRadius: SizeTokens.small,
                        topTrailingRadius: SizeTokens.small
                    )
                )
                .padding()
            }
            content()
            Spacer()
        }
        .transition(.slide)
        .animation(.easeInOut, value: error != nil)
    }
}
