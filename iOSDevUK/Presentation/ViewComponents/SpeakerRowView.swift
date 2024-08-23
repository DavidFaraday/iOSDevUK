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
        HStack(spacing: 12) {
            RemoteImageView(url: speaker.imageUrl)
                .scaledToFit()
                .frame(width: 62, height: 62)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 10) {
                Text(speaker.name)
                    .foregroundStyle(Color(.mainText))
                    .minimumScaleFactor(0.8)
                    .lineLimit(2)
                    .boldAppFont(size: 18)
                
                if let position = speaker.currentPosition, !position.isEmpty {
                    Text(position)
                        .foregroundStyle(Color(.textGrey))
                        .minimumScaleFactor(0.8)
                        .semiboldAppFont(size: 16)
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
        }
        .roundBackgroundView(color: Color(.cardBackground))
    }
}

#Preview {
    SpeakerRowView(speaker: DummyData.speakers.first!)
}
