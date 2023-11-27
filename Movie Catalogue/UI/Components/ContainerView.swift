//
//  ContainerView.swift
//  Movie Catalogue
//
//  Created by Elvis Mwenda on 26/11/2023.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    var error: Error?
    var dismissError: () -> Void
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(spacing: .zero) {
            if let error {
                HStack {
                    VStack(alignment: .leading) {
                        Text(with: .error)
                            .lineLimit(2)
                            .font(.title3)
                        if let error = error as? LocalizedError {
                            Text(error.errorDescription ?? error.localizedDescription)
                                .lineLimit(2)
                                .font(.caption)
                        } else {
                            Text(error.localizedDescription)
                                .lineLimit(2)
                                .font(.caption)
                        }

                    }
                    .padding()

                    Spacer()

                    Button {
                        dismissError()
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
        }
    }
}
