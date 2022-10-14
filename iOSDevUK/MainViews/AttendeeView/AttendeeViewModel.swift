//
//  AttendeeViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI
import Combine

final class AttendeeViewModel: ObservableObject {
    
    @Published private(set) var allLocations: [Location] = []
    @Published private(set) var informationItems: [InformationItem] = []
    
    private var cancellables: Set<AnyCancellable> = []

    @MainActor
    @Sendable func listenForLocations() async {
        FirebaseLocationListener.shared.listenForLocations()
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    print("Error fetching locations: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] locations in
                self?.allLocations = locations
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    @Sendable func fetchInformationItems() async {
        informationItems = DummyData.informationItems
    }
}
