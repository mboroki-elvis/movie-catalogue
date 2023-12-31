import SwiftUI

struct LanguageAndProducersView: View {
    var languages: [String]
    var producers: [String]
    var year: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(with: .languages)
                .foregroundColor(.onContainer)
                .font(.headline)
            ForEach(languages, id: \.self) { language in
                Text(language)
                    .font(.caption)
                    .foregroundColor(.onContainer)
            }

            Text(with: .producers)
                .foregroundColor(.onContainer)
                .font(.headline)
            ForEach(producers, id: \.self) { producer in
                Text(producer)
                    .font(.caption)
                    .foregroundColor(.onContainer)
            }

            Text(with: .released)
                .foregroundColor(.onContainer)
                .font(.headline)

            Text(year)
                .foregroundColor(.onContainer)
                .font(.caption)
        }
    }
}
