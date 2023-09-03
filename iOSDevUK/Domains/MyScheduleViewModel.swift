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
    @Injected(\.localStorage) private var localStorage
    
    @Published private(set) var favoriteSessionIds: [String] = []
    @Published private(set) var sessions: [Session] = []
    @Published private(set) var groupedSessions: [String: [Session]] = [:]

    private var cancellables: Set<AnyCancellable> = []

    init() {
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

    
    func setSessions(allSessions: [Session], favSessionIds: [String]) {
        self.favoriteSessionIds = favSessionIds
        self.sessions = allSessions
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
}
