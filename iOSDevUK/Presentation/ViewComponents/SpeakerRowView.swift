//
//  SpeakerRowView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 15/03/2024.
//

import SwiftUI

struct SpeakerRowView: View {
    let speaker: Speaker
    
    var body: some View {
        HStack(spacing: 8) {
            RemoteImageView(url: speaker.imageUrl)
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 10) {
                Text(speaker.name)
                    .foregroundStyle(Color(ColorNames.textColor))
                    .minimumScaleFactor(0.8)
                    .lineLimit(2)
                    .boldAppFont(size: 16)
                
                if let position = speaker.currentPosition {
                    Text(position)
                        .foregroundStyle(Color(ColorNames.textGrey))
                        .minimumScaleFactor(0.8)
                        .semiboldAppFont(size: 14)
                }
            }
        }
    }
}

#Preview {
    SpeakerRowView()
}
