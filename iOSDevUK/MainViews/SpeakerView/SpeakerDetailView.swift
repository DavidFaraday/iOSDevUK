//
//  SpeakerDetailView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct SpeakerDetailView: View {
    
    var speaker: Speaker!
    let imageWidth: CGFloat = 160
    
    init(speaker: Speaker) {
        self.speaker = speaker
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: imageWidth + 5)
                    .foregroundColor(.green)
                RemoteImage(urlString: speaker.imageLink)
                    .frame(width: imageWidth, height: imageWidth)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .center, spacing: 5) {
                Text(speaker.name)
                    .font(.largeTitle)
                    .minimumScaleFactor(0.7)
                
                //TODO: This should be link buttons to twitter and linkedin
                HStack(spacing: 10) {
                    Text("Twitter \(speaker.twitterId)")
                        .font(.subheadline)
                        .minimumScaleFactor(0.7)
                    
                    Text(speaker.linkedIn)
                        .font(.subheadline)
                        .minimumScaleFactor(0.7)
                }
                .padding(.bottom, 20)

                
                Divider()

                VStack(alignment: .leading) {
                    Text(speaker.biography)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10)
                    
                    Divider()

                    Text("Session(s)")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.top)
                    //TODO: Get sessions and show here
                    //TODO: there may be other info like slide links etc "See also"
                }
            }
            .padding(20)
            
            Spacer()
        }
    }
}

struct SpeakerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerDetailView(speaker: Speaker.dummySpeaker)
    }
}
