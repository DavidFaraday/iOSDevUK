//
//  SessionDetailViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import Foundation

final class SessionDetailViewModel: ObservableObject {
    
    @Published private(set) var session: Session
    @Published private(set) var speakers: [Speaker]?
    @Published private(set) var location: Location?
    let imageNames = ["img1", "img2", "img3", "img4"]
    
    init(session: Session) {
        self.session = session
    }
    
    @MainActor
    @Sendable func fetchSpeakers() async {
        self.speakers = [DummyData.speaker, DummyData.speakers[0]]
    }

    @MainActor
    @Sendable func fetchLocation() async {
        self.location = DummyData.location
    }
}
