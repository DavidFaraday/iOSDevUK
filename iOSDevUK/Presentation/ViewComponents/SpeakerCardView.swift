//
//  SpeakerCellView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct SpeakerCardView: View {
    
    let speaker: Speaker
    
    var body: some View {
        VStack(spacing: 8) {
            RemoteImageView(url: speaker.imageUrl)
                .scaledToFit()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
            
            Text(speaker.name)
                .foregroundStyle(Color(ColorNames.textColor))
                .minimumScaleFactor(0.6)
                .lineLimit(2, reservesSpace: true)
                .semiboldAppFont(size: 14)
        }
    }
}

struct SpeakerCellView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerCardView(speaker: DummyData.speakers[0])
    }
}
