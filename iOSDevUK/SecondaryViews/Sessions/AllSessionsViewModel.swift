//
//  AllSessionsViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 30/10/2022.
//

import SwiftUI

final class AllSessionsViewModel: ObservableObject {
    
    @Published var sessions: [Session]
    @Published var selectedDate = ""

    init(sessions: [Session]) {
        self.sessions = sessions
    }
    
    @MainActor
    func setCurrentDate() {
        let currentDay = Calendar.current.dateComponents([. month], from: Date())

        for session in sessions {
            let sessionStartDay = Calendar.current.dateComponents([. month], from: session.startDate)
            
            if currentDay == sessionStartDay {
                selectedDate = session.startingDay
                return
            }
        }
        selectedDate = sessions.first?.startingDay ?? ""
    }
}
