//
//  SessionDetailViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import Factory
import SwiftUI
import Combine

final class SessionDetailViewModel: ObservableObject {
    @Injected(\.firebaseRepository) private var firebaseRepository
    @Injected(\.localStorage) private var localStorage

    @Published private(set) var fetchError: Error?

    @Published private(set) var session: Session?
    @Published private(set) var speakers: [Speaker]?
    @Published private(set) var location: Location?
    
    @Published var showError = false
    @Published var favoriteSessionIds: [String] = []
    @Published var isSessionFavorite = false

    private var cancellables: Set<AnyCancellable> = []

    private let sessionId: String

    init(sessionId: String, session: Session? = nil) {
        self.sessionId = sessionId
        self.session = session

        $fetchError
            .dropFirst()
            .sink { [weak self] _ in
                self?.showError = true
            }
            .store(in: &cancellables)
        
        $favoriteSessionIds
            .map { $0.contains(sessionId) }
            .assign(to: &$isSessionFavorite)
        
        loadFavSessions()
    }
    
    @MainActor
    func fetchSession() async {
        guard session == nil else { return }

        do {
            session = try await firebaseRepository.getDocument(from: .Session, with: sessionId)
        } catch (let error) {
            fetchError = error
        }
    }

    @MainActor
    func fetchSpeakers() async {
        guard let session = session else { return }

        if speakers == nil {
            speakers = []
            
            await withTaskGroup(of: Void.self) { taskGroup in
                
                for id in session.speakerIds {
                    taskGroup.addTask {
                        await self.fetchSpeaker(with: id)
                    }
                }
            }
        }
    }
    
    @MainActor
    private func fetchSpeaker(with id: String) async {
        
        do {
            let speaker: Speaker? = try await firebaseRepository.getDocument(from: .Speaker, with: id)

            guard let speaker = speaker else { return }
            self.speakers?.append(speaker)
        } catch (let error) {
            fetchError = error
        }
    }

    @MainActor
    func fetchLocation() async {

        guard let session = session else { return }
        guard location == nil else { return }

        if let locationId = session.locationId {
            do {
                self.location = try await firebaseRepository.getDocument(from: .Location, with: locationId)
            } catch (let error) {
                fetchError = error
            }
        }
    }
    
    @MainActor
    func resetError() {
        self.fetchError = nil
    }
        
    @MainActor
    func updateFavoritSession() {
        if let index = favoriteSessionIds.firstIndex(of: sessionId) {
            favoriteSessionIds.remove(at: index)
        } else {
            favoriteSessionIds.append(sessionId)
        }
        
        localStorage.save(items: favoriteSessionIds, for: AppConstants.sessionKey)
        loadFavSessions()
    }
    
    private func loadFavSessions() {
        self.favoriteSessionIds = localStorage.loadArray(with: AppConstants.sessionKey)
    }
}
