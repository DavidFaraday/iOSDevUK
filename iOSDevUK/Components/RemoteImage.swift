//
//  RemoteImage.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct RemoteImage: View {
    
    let imageURL: URL!
//    let width: CGFloat!
//    let height: CGFloat!
    
    init(urlString: String) {
        self.imageURL = URL(string: urlString)
//        self.width = width
//        self.height = height
    }
    
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                
            case .failure:
                Rectangle()
                    .foregroundColor(.gray)
                    .cornerRadius(15)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(urlString: "https://picsum.photos/150/300")
    }
}
