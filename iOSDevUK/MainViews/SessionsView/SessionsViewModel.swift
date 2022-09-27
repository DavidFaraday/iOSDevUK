//
//  SessionsViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

final class SessionsViewModel: ObservableObject {
    
    @Published var sessions: [Session] = []

    @MainActor
    func getSessions() async {
        sessions = await FirebaseSessionListener.shared.getSessions()
    }
}

