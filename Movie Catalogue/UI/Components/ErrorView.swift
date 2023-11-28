import SwiftUI

struct ErrorView: View {
    let error: Error
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.onContainer)
            Text(with: .error)
                .foregroundColor(.onContainer)
            Text(error.localizedDescription)
                .foregroundColor(.onContainer)
        }
        .background(.container)
    }
}

#Preview {
    ErrorView(error: NSError(domain: Bundle.main.bundleIdentifier!, code: 0))
}
