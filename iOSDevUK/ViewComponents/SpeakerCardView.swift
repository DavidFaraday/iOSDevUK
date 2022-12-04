//
//  SpeakerCellView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct SpeakerCardView: View {
    
    private let speaker: Speaker
    private let height: CGFloat
    private let gradient = Gradient(colors:
                                        [.green.opacity(1.0),
                                         .green.opacity(0.8),
                                         .green.opacity(0.7),
                                         .green.opacity(0.2),
                                         .green.opacity(0.1),
                                         .clear])
    
    init(speaker: Speaker, height: CGFloat = 180) {
        self.speaker = speaker
        self.height = height
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RemoteImageView(url: speaker.imageUrl)
                .frame(height: height)
                .scaledToFit()
                .cornerRadius(15)

            ZStack(alignment: .leading) {
                Rectangle()
                    .background(
                        LinearGradient(gradient: gradient,
                                       startPoint: .bottom,
                                       endPoint: .top)
                    )
                    .frame(height: 65)
                    .cornerRadius(15)
                    .foregroundColor(.clear)
                
                Text(speaker.name)
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .font(.subheadline)
                    .bold()
                    .padding(.horizontal, 10)
                    .padding(.top, 15)
            }
        }
        .frame(height: height)
    }
}

struct SpeakerCellView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerCardView(speaker: DummyData.speakers[0])
    }
}
