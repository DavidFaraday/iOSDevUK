//
//  SpeakerDetailViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/09/2022.
//

import SwiftUI
import Combine

final class SpeakerDetailViewModel: ObservableObject {
    private let firebaseRepository: FirebaseRepositoryProtocol
    
    @Published private(set) var fetchError: Error?

    @Published private(set) var sessions:[Session] = []
    @Published private(set) var speaker: Speaker
    @Published private(set) var webLinks: [Weblink] = []
    
    @Published var showError = false
    private var cancellables: Set<AnyCancellable> = []

    init(speaker: Speaker, firebaseRepository: FirebaseRepositoryProtocol = FirebaseRepository.shared) {
        self.speaker = speaker
        self.firebaseRepository = firebaseRepository
        
        $fetchError
            .dropFirst()
            .sink { [weak self] _ in
            self?.showError = true
            }
            .store(in: &cancellables)
        
        $speaker
            .map( { $0.webLinks ?? [] })
            .assign(to: &$webLinks)
    }
    
    
    
    @MainActor
    func getSpeakerSessions() async {
        do {
            sessions = try await firebaseRepository.getDocuments(from: .Session, where: FirebaseKeys.speakerIds, arrayContains: speaker.id) ?? []
        } catch (let error) {
            fetchError = error
        }
    }
}
