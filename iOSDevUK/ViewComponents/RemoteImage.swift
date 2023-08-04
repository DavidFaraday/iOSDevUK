//
//  RemoteImage.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import Kingfisher
import SwiftUI

struct RemoteImageView: View {
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    var body: some View {
        KFImage.url(url)
            .placeholder {
                Image(ImageNames.placeholder)
                    .resizable()
            }
            .resizable()
            .loadDiskFileSynchronously()
//            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .aspectRatio(contentMode: .fit)
    }
}


struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(url: URL(string: "https://xsgames.co/randomusers/avatar.php?g=male") )
    }
}
