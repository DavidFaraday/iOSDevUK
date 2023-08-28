//
//  MyScheduleViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//
import Combine
import SwiftUI
import Factory

final class MyScheduleViewModel: ObservableObject {
    @Injected(\.firebaseRepository) private var firebaseRepository
    @Injected(\.localStorage) private var localStorage
    
    @Published private(set) var favoriteSessionIds: [String] = []
    @Published private(set) var sessions: [Session] = []
    @Published private(set) var groupedSessions: [String: [Session]] = [:]
    @Published private(set) var eventInformation: EventInformation?
    @Published private(set) var fetchError: Error?

    private var cancellables: Set<AnyCancellable> = []

    init() {
        self.loadFavSessions()
        self.observerData()
    }
    
    private func observerData() {
        $sessions
            .sink(receiveValue: { receivedSessions in
                
                let filteredSessions = receivedSessions.filter { self.favoriteSessionIds.contains($0.id) }

                self.groupedSessions = .init(
                    grouping: filteredSessions,
                    by: { $0.startingDay }
                )
            })
            .store(in: &cancellables)
    }

    
    func setSessions(allSessions: [Session]) {
        self.sessions = allSessions
    }
    

    @MainActor
    @Sendable func listenForEventNotification() async {
        guard eventInformation == nil else { return }

        do {
            try await firebaseRepository.listen(from: .AppInformation)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        return
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }, receiveValue: { [weak self] eventInformations in
                    self?.eventInformation = eventInformations.first
                })
                .store(in: &cancellables)
        } catch (let error) {
            fetchError = error
        }
    }
    
    func delete(for indexSet: IndexSet, key: String) {
        guard let firstIndex = indexSet.first,
              let session = groupedSessions[key]?.at(firstIndex) else {
            return
        }

        groupedSessions[key]?.remove(at: firstIndex)
        favoriteSessionIds.removeAll { $0 == session.id }
        localStorage.save(items: favoriteSessionIds, for: AppConstants.sessionKey)
    }
    
    
    func loadFavSessions() {
        self.favoriteSessionIds = localStorage.loadArray(with: AppConstants.sessionKey)
    }

    func updateFavoriteSession(id: String) {
        if let index = self.favoriteSessionIds.firstIndex(of: id) {
            self.favoriteSessionIds.remove(at: index)
        } else {
            self.favoriteSessionIds.append(id)
        }
        
        localStorage.save(items: self.favoriteSessionIds, for: AppConstants.sessionKey)
        loadFavSessions()
    }
}
