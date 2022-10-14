//
//  AttendeeViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

final class AttendeeViewModel: ObservableObject {
    
    @Published private(set) var allLocations: [Location] = []
    @Published private(set) var informationItems: [InformationItem] = []

    @MainActor
    @Sendable func fetchLocations() async {
        allLocations = await FirebaseLocationListener.shared.getLocations()
    }
    
    @MainActor
    @Sendable func fetchInformationItems() async {
        informationItems = DummyData.informationItems
    }
}
