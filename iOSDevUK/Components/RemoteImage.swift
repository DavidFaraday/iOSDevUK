//
//  RemoteImage.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import CachedAsyncImage
import SwiftUI

struct RemoteImageView: View {
    private let url: URL?

    init(url: URL?) {
        self.url = url
    }

    var body: some View {
        ZStack {
            CachedAsyncImage(
                url: url,
                content: { image in
                    image.resizable()
                },
                placeholder: {
                    Rectangle()
                        .fill(.gray.gradient)
                        .cornerRadius(15)
                })
        }
    }
}
