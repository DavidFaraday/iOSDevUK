//
//  SpeakerDetailViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/09/2022.
//

import SwiftUI
import Factory
import Combine

final class SpeakerDetailViewModel: ObservableObject {
    @Injected(\.firebaseRepository) private var firebaseRepository
    @Published private(set) var fetchError: Error?

    @Published private(set) var sessions:[Session] = []
    @Published private(set) var speaker: Speaker
    
    @Published var showError = false
    private var cancellables: Set<AnyCancellable> = []

    init(speaker: Speaker) {
        self.speaker = speaker
        
        $fetchError
            .dropFirst()
            .sink { [weak self] _ in
            self?.showError = true
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    @Sendable func getSpeakerSessions() async {
        do {
            sessions = try await firebaseRepository.getDocuments(from: .Session, where: FirebaseKeys.speakerIds, arrayContains: speaker.id) ?? []
        } catch (let error) {
            fetchError = error
        }
    }
}
