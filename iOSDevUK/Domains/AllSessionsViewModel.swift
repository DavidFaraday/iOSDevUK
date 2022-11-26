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
        let currentDayMonth = Calendar.current.dateComponents([.month, .day], from: Date())
        
        for session in sessions {
            let sessionDayMont = Calendar.current.dateComponents([.month, .day], from: session.startDate)

            if currentDayMonth == sessionDayMont {
                selectedDate = session.startingDay
                return
            }
        }
        
        selectedDate = sessions.first?.startingDay ?? ""
    }
}
