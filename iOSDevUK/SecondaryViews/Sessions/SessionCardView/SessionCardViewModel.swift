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
            print("fetch speakers for card")
            self.speakers = [DummyData.speaker, DummyData.speakers[0]]
        }
    }

    @MainActor
    @Sendable func fetchLocation() async {
        if location == nil {
            print("fetch location for Card")
            self.location = DummyData.location
        }
    }
}
