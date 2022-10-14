//
//  SessionsViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI
import Combine

final class SessionsViewModel: ObservableObject {
    @Published private(set) var sessions: [Session] = []
    private var cancellables: Set<AnyCancellable> = []

    @MainActor
    @Sendable func fetchSessions() async {
        FirebaseSessionListener.shared.getSessions()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] allSessions in
                self?.sessions = allSessions.sorted { $0.startDate < $1.startDate }
            })
            .store(in: &cancellables)
    }
}

