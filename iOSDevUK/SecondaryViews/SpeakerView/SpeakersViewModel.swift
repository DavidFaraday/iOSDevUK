//
//  SpeakersViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

final class SpeakersViewModel: ObservableObject {
    
    @Published private(set) var speakers: [Speaker] = []
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @MainActor
    @Sendable func getSpeakers() async {
        speakers = await FirebaseSpeakerListener.shared.getSpeakers()
    }
}
