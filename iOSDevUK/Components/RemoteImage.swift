//
//  RemoteImage.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct RemoteImage: View {
    
    let imageURL: URL!
    
    init(urlString: String) {
        self.imageURL = URL(string: urlString)
    }
    
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .scaleEffect(2)
            case .success(let image):
                image.resizable()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(urlString: "https://picsum.photos/200")
    }
}
