import SwiftUI

struct ErrorView: View {
    let error: Error
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(ColorTokens.onContainer.color)
            Text("Ooops!! Something went wrong")
                .foregroundColor(ColorTokens.onContainer.color)
            Text(error.localizedDescription)
                .foregroundColor(ColorTokens.onContainer.color)
        }
        .background(ColorTokens.container.color)
    }
}

#Preview {
    ErrorView(error: NSError(domain: Bundle.main.bundleIdentifier!, code: 0))
}
