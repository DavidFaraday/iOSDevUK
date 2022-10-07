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
                                        [.blue.opacity(0.9),
                                         .blue.opacity(0.7),
                                         .clear])
    init(speaker: Speaker) {
        self.speaker = speaker
    }
    
    var body: some View {
        ZStack {
            RemoteImage(urlString: speaker.imageLink)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)

            VStack {
                Spacer()
                ZStack(alignment: .leading) {
                    Rectangle()
                        .background(
                            LinearGradient(gradient:
                                            gradient,
                                           startPoint: .bottom,
                                           endPoint: .top)
                        )
                        .frame(height: 60)
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
}

struct SpeakerCellView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerCardView(speaker: DummyData.speaker)
    }
}
