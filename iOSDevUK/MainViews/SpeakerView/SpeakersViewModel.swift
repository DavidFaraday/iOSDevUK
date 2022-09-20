//
//  SpeakersViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

final class SpeakersViewModel: ObservableObject {
    
    @Published var speakers:[Speaker] = []

    @MainActor
    func getSpeakers() async {
        speakers = await FirebaseSpeakerListener.shared.getSpeakers()
    }

    func createSpeaker() {
        FirebaseSpeakerListener.shared.saveSpeaker(Speaker.dummySpeaker)
    }
}
