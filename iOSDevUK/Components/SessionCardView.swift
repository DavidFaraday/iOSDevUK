//
//  SessionCardView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

struct SessionCardView: View {
    var session: Session!
    var speaker: Speaker!
    var location: Location!
    
    let offset: CGFloat = 3
    
    init(session: Session, speaker: Speaker, location: Location) {
        self.session = session
        self.speaker = speaker
        self.location = location
    }
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue.opacity(0.7))

                Rectangle()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .offset(CGSize(width: offset, height: 2))

                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(session.title)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .font(.title2)
                            .bold()

                        Text(speaker.name)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .font(.subheadline)
                            .bold()
                        
                        //TODO: Set the date to week day and time add multiple speakers
                        Text("\(location.name) - \(session.startDate)")
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .font(.subheadline)
                            .bold()


                    }
                    
                    Spacer()
                    //TODO: Multiple speakers
                    RemoteImage(urlString: "https://picsum.photos/100")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                        .cornerRadius(30)
                        .padding(5)
                }
                .padding([.top, .leading])
            }
        }
        .padding(.bottom)
    }
}

struct SessionCardView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCardView(session: Session.dummySession, speaker: Speaker.dummySpeaker, location: Location.dummyLocation)
    }
}
