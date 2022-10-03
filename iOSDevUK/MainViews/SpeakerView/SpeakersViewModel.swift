//
//  SpeakersViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

final class SpeakersViewModel: ObservableObject {
    
    @Published var speakers: [Speaker] = []
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @MainActor
    func getSpeakers() async {
        speakers = await FirebaseSpeakerListener.shared.getSpeakers()
    }
}
