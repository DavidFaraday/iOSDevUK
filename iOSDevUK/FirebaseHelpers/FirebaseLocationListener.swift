//
//  FirebaseLocationListener.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import Foundation
import FirebaseFirestoreSwift

class FirebaseLocationListener {
    
    static let shared = FirebaseLocationListener()
    
    private init () { }
    
    func getLocations() async -> [Location] {
       
        return await withCheckedContinuation { continuation in
            
            FirebaseReference(.Location).getDocuments { querySnapshot, error in
                
                var locations: [Location] = []
                
                guard let documents = querySnapshot?.documents else {
                    continuation.resume(returning: locations)
                    return
                }

                locations = documents.compactMap { (queryDocumentSnapshot) -> Location? in
                    return try? queryDocumentSnapshot.data(as: Location.self)
                }
                continuation.resume(returning: locations)
            }
        }
    }
        
    func saveLocation(_ location: Location) {
        
        do {
            try FirebaseReference(.Location).document(location.id).setData(from: location)
        }
        catch {
            print("Error saving location", error.localizedDescription)
        }
    }
    
    func deleteLocation(_ location: Speaker) {
        FirebaseReference(.Location).document(location.id).delete()
    }
}
