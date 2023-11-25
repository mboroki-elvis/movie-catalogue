import SwiftUI

struct AsyncImageCache: View {
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction

    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction()
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
    }

    var body: some View {
        if let cached = ImageCache[url] {
            content(phase: .success(cached))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }

    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }

        return content(phase: phase)
    }
    
    @ViewBuilder func content(phase: AsyncImagePhase) -> some View {
       switch phase {
       case .empty:
           ProgressView().foregroundStyle(.accent)
       case .success(let image):
           image
               .resizable()
               .aspectRatio(contentMode: .fill)
       case .failure(let error):
           ErrorView(error: error)
       @unknown default:
           fatalError()
       }
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}

#Preview {
    AsyncImageCache(
        url: URL(string: defaultMovie.backdropURLString!)!
    ) 
}



