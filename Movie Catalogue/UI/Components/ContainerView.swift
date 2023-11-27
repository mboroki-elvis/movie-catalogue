//
//  ContainerView.swift
//  Movie Catalogue
//
//  Created by Elvis Mwenda on 26/11/2023.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    @State var error: Error?
    let content: () -> Content
    var body: some View {
        VStack(spacing: .zero) {
            if let error {
                HStack {
                    VStack(alignment: .leading) {
                        Text(with: .error)
                            .lineLimit(2)
                            .font(.title3)
                        Text(error.localizedDescription)
                            .lineLimit(2)
                            .font(.caption)
                    }
                    .padding()

                    Spacer()

                    Button {
                        self.error = nil
                    } label: {
                        Image(systemName: "close")
                            .font(.title)
                            .foregroundStyle(Color.onContainer)
                    }
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
        }
    }
}
