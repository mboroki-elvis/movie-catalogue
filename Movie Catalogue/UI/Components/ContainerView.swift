//
//  ContainerView.swift
//  Movie Catalogue
//
//  Created by Elvis Mwenda on 26/11/2023.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    var error: Error?
    let content: () -> Content
    var body: some View {
        VStack {
            if let error {
                HStack {
                    VStack(alignment: .leading) {
                        Text(with: .error)
                            .lineLimit(2)
                            .font(.title)
                        Text(error.localizedDescription)
                            .lineLimit(2)
                            .font(.caption)
                    }                    
                }
                .background(.accent.opacity(0.7))
                .padding()
            }
            content()
        }
    }
}
