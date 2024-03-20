//
//  AllSessionsViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 30/10/2022.
//

import SwiftUI
import Factory
import Combine

final class AllSessionsViewModel: ObservableObject {
    @Injected(\.firebaseRepository) private var firebaseRepository
    
    @Published private(set) var fetchError: Error?
    @Published private(set) var eventInformation: EventInformation?
    @Published var sessions: [Session] = []
    @Published var selectedDate = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    @MainActor
    func setCurrentDate() {
        guard !sessions.isEmpty else { return }
        
        //applies date preselection only during the conference
        if let startDate = eventInformation?.startDate, let endDate = eventInformation?.endDate {
            if !Date().isInRange(startDate: startDate, endDate: endDate) {
                return
            }
        }
        
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
    
    @MainActor
    func fetchEventNotification() async {
        guard eventInformation == nil else { return }
        
        do {
            self.eventInformation = try await firebaseRepository.getDocuments(from: .AppInformation)?.first
        } catch (let error) {
            fetchError = error
        }

//        do {
//            try await firebaseRepository.listen(from: .AppInformation)
//                .sink(receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        return
//                    case .failure(let error):
//                        print("Error: \(error.localizedDescription)")
//                    }
//                }, receiveValue: { [weak self] eventInformations in
//                    self?.eventInformation = eventInformations.first
//                })
//                .store(in: &cancellables)
//        } catch (let error) {
//            fetchError = error
//        }
    }

    func setSessions(sessions: [Session]) {
        self.sessions = sessions
    }
}
