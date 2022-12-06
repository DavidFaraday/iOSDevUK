//
//  SpeakerDetailViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/09/2022.
//

import SwiftUI
import Factory

final class SpeakerDetailViewModel: ObservableObject {
    @Injected(Container.firebaseRepository) private var firebaseRepository
    
    @Published private(set) var sessions:[Session] = []
    @Published private(set) var speaker: Speaker
    
    init(speaker: Speaker) {
        self.speaker = speaker
    }
    
    @MainActor
    @Sendable func getSpeakerSessions() async {
        do {
            sessions = try await firebaseRepository.getDocuments(from: .Session, where: FirebaseKeys.speakerIds, arrayContains: speaker.id) ?? []
        } catch {
            print("Error getting sessions")
        }
    }
}
