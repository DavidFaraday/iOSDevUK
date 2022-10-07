//
//  HomeViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Environment(\.openURL) var openURL

    @Published private(set) var aboutString = ""
    @Published private(set) var eventNotification = ""
    @Published private(set) var sessions: [Session] = []
    @Published private(set) var speakers: [Speaker] = []
    
    func showTwitterAccount(_ twitterId: String) {
        guard let url = URL(string: "https://twitter.com/\(twitterId)") else { return }
        self.openURL(url)
    }
    
    @MainActor
    @Sendable func fetchSessions() async {
        self.sessions = DummyData.sessions
    }

    @MainActor
    @Sendable func fetchSpeakers() async {
        self.speakers = DummyData.speakers
    }
    
    @MainActor
    @Sendable func fetchEventNotification() async {
        self.aboutString = DummyData.aboutString
    }

    @MainActor
    @Sendable func fetchAboutString() async {
        self.eventNotification = DummyData.eventNotification
    }
}
