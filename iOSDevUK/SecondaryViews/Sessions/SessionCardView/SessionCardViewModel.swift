//
//  SessionCardViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/10/2022.
//

import SwiftUI

final class SessionCardViewModel: ObservableObject {
    
    @Published private(set) var session: Session
    @Published private(set) var speakers: [Speaker]?
    @Published private(set) var location: Location?
    
    init(session: Session) {
        self.session = session
    }
    
    @MainActor
    @Sendable func fetchSpeakers() async {
        if speakers == nil {
            //TODO: Make group task here
            var tempSpeakers: [Speaker] = []
            
            for id in session.speakerIds {
                let speaker = await FirebaseSpeakerListener.shared.getSpeaker(with: id)
                guard let speaker = speaker else { return }
                tempSpeakers.append(speaker)
            }
            self.speakers = tempSpeakers
        }
    }

    @MainActor
    @Sendable func fetchLocation() async {
        if location == nil {
            self.location = await FirebaseLocationListener.shared.getLocation(with: session.locationId)
        }
    }
}
