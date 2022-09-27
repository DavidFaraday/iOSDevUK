//
//  SpeakerDetailViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/09/2022.
//

import SwiftUI

final class SpeakerDetailViewModel: ObservableObject {

    @Environment(\.openURL) var openURL
    //    @Published var sessions:[Session] = []

    @MainActor
    func getSessionsFor(_ speakerId: String) async {
        print("getting session for", speakerId)
//        sessions = await FirebaseSessionListener.shared.getSessions()
    }

    
    func showTwitterAccount(_ twitterId: String) {
        guard let url = URL(string: "https://twitter.com/\(twitterId)") else { return }
        self.openURL(url)
    }

    func showLinkedInAccount(_ linkedInId: String) {
        guard let url = URL(string: "https://linkedIn.com/in/\(linkedInId)") else { return }
        self.openURL(url)
    }
}
