//
//  SessionDetailViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import Foundation

final class SessionDetailViewModel: ObservableObject {
    
    @Published var speakers: [Speaker] = []
    @Published var location: Location? = nil
    
    
    func loadData(for session: Session) async {
        Task {
            self.location = await getLocation()
            self.speakers = await getSpeakers()
        }
    }
    
    
    private func getSpeakers() async -> [Speaker] {
        return [DummyData.speaker]
    }
    
    private func getLocation() async -> Location {
        return DummyData.location
    }

}
