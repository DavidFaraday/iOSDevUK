//
//  SessionsViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

final class SessionsViewModel: ObservableObject {
    @Published private(set) var sessions: [Session] = []

    @MainActor
    @Sendable func fetchSessions() async {
        self.sessions = DummyData.sessions.sorted { $0.startDate < $1.startDate }
    }
}

