//
//  SpeakerCellView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct SpeakerCardView: View {
    
    private let speaker: Speaker
    private let gradient = Gradient(colors:
                                        [Color(ColorNames.primary).opacity(1.0),
                                         Color(ColorNames.primary).opacity(0.8),
                                         Color(ColorNames.primary).opacity(0.7),
                                         Color(ColorNames.primary).opacity(0.2),
                                         Color(ColorNames.primary).opacity(0.1),
                                         .clear])
    
    init(speaker: Speaker) {
        self.speaker = speaker
    }
    
    var body: some View {
        RemoteImageView(url: speaker.imageUrl)
            .scaledToFit()
            .cornerRadius(16)
            .overlay(alignment: .bottom) {
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
    }
}

struct SpeakerCellView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerCardView(speaker: DummyData.speakers[0])
    }
}
