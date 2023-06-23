//
//  AdminLocationViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/03/2023.
//

import Foundation
import Factory

final class AdminLocationViewModel: ObservableObject {
    @Injected(\.firebaseRepository) private var firebaseRepository

    @Published var name = ""
    @Published var note = "Notes"
    @Published var locationType = LocationType.au
    @Published var imageLink = ""
    @Published var latitude = ""
    @Published var longitude = ""
    
    var location: Location?
    
    init(location: Location? = nil) {
        self.location = location
        setupUI()
    }
    
    private func setupUI() {
        guard let location = location else { return }
        
        name = location.name
        note = location.note
        imageLink = location.imageLink ?? ""
        latitude = "\(location.latitude)"
        longitude = "\(location.longitude)"
        locationType = location.locationType
    }
    
    func save() async {
        let newLocation = Location(id: location?.id ?? UUID().uuidString, name: name, note: note, imageLink: imageLink, latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0, webLink: nil, locationType: locationType)
    
        do {
            try firebaseRepository.saveData(data: newLocation, to: .Location)
        } catch {
            print("Error saving location", error.localizedDescription)
        }
    }
    
    func deleteLocation(_ location: Location) {
        firebaseRepository.deleteDocument(with: location.id, from: .Location)
    }
    
    func invalidForm() -> Bool {
        name == "" || latitude == "" || longitude == "" || note == ""
    }
}
