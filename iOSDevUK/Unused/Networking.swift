//
//  Networking.swift
//  iOSDevUK
//
//  Created by David Kababyan on 11/09/2022.
//

import SwiftUI

enum AppError: Error {
    case failedToFetchLocations
}

//MARK: - used only to get files from JSON and save to Firebase
final class NetworkService {
    
    static let shared = NetworkService()
    
    private let baseUrlString = "https://blue-ocean-0c74f0b03.1.azurestaticapps.net/data"
    
    private init() { }
    
    func fetchAllLocations() async throws -> [Location] {
        
        let locationsUrlString = baseUrlString.appending("/locations.json")

        guard let dataUrl = URL(string: locationsUrlString) else {
            throw AppError.failedToFetchLocations
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: dataUrl)
//
//            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                //print(json)
//            }
            
            let locationObject = try JSONDecoder().decode(LocationObject.self, from: data)
            return locationObject.locations
        } catch {
            throw AppError.failedToFetchLocations
        }
    }
}

