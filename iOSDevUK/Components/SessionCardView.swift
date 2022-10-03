//
//  SessionCardView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

struct SessionCardView: View {
    private let session: Session
    private let speakers: [Speaker]
    private let location: Location
    
    let offset: CGFloat = 3
    
    init(session: Session, speakers: [Speaker], location: Location) {
        self.session = session
        self.speakers = speakers
        self.location = location
    }
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .topLeading) {

                Rectangle()
                    .foregroundColor(.blue.opacity(0.7))
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                //TODO: refactor the text format
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(session.title)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .font(.title2)
                            .bold()

                        VStack(spacing: 5) {
                            ForEach(speakers) { speaker in
                                Text(speaker.name)
                                    .multilineTextAlignment(.leading)
                                    .minimumScaleFactor(0.6)
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .bold()
                            }
                        }

                        Text("\(location.name) - \(session.startDate.weekDayTime())")
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .font(.subheadline)
                            .bold()
                    }

                    Spacer()

                    VStack(spacing: 0) {
                        ForEach(speakers) { speaker in
                            RemoteImage(urlString: "https://picsum.photos/100")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 45)
                                .cornerRadius(30)
                                .padding(5)
                        }
                    }
                }
                .padding([.top, .leading])
            }
        }
        .padding(.bottom)
    }
}

struct SessionCardView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCardView(session: Session.dummySession, speakers: [Speaker.dummySpeaker, Speaker.dummySpeaker], location: Location.dummyLocation)
    }
}
