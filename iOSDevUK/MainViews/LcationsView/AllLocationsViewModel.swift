//
//  AllLocationsViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

final class AllLocationsViewModel: ObservableObject {
    @Published var locations: [Location] = []

    @MainActor
    func getLocations() async {
        locations = await FirebaseLocationListener.shared.getLocations()
    }
}
