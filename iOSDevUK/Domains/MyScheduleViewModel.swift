//
//  MyScheduleViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//
import Combine
import SwiftUI

final class MyScheduleViewModel: ObservableObject {
    private let localStorage: LocalStorageServiceProtocol
    private let firebaseRepository: FirebaseRepositoryProtocol

    @Published private(set) var favoriteSessionIds: [String] = []
    @Published private(set) var sessions: [Session] = []
    @Published private(set) var groupedSessions: [String: [Session]] = [:]
    @Published private(set) var fetchError: Error?

    private var cancellables: Set<AnyCancellable> = []

    init(
        localStorage: LocalStorageServiceProtocol = LocalStorageService.shared,
        firebaseRepository: FirebaseRepositoryProtocol = FirebaseRepository.shared
    ) {
        self.localStorage = localStorage
        self.firebaseRepository = firebaseRepository
        self.observerData()
    }
    
    private func observerData() {
        $sessions
            .sink(receiveValue: { receivedSessions in
                self.updateGroupedSessions(sessions: receivedSessions)
            })
            .store(in: &cancellables)
    }

    @MainActor
    func listenForSessions() async {
        guard self.sessions.isEmpty else { return }
        
        do {
            try await firebaseRepository.listen(from: .Session)
                .sink(receiveCompletion: { completion in
                    switch completion {
                        case .finished:
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                    }
                }, receiveValue: { [weak self] allSessions in
                    self?.sessions = allSessions.sorted()
                })
                .store(in: &cancellables)
        } catch (let error) {
            fetchError = error
        }
    }

    
    func setFavSessions(favSessionIds: [String]) {
        self.favoriteSessionIds = favSessionIds
        updateGroupedSessions(sessions: self.sessions)
    }

    private func updateGroupedSessions(sessions: [Session]) {
        let filteredSessions = sessions.filter { self.favoriteSessionIds.contains($0.id) }

        self.groupedSessions = .init(
            grouping: filteredSessions,
            by: { $0.startingDay }
        )
    }
}
