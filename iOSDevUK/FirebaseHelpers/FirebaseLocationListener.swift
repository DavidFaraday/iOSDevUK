//
//  FirebaseLocationListener.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import Foundation
import FirebaseFirestoreSwift
import Combine

class FirebaseLocationListener {
    
    static let shared = FirebaseLocationListener()
    
    private init () { }
    
    func getLocation(with id: String) async -> Location? {
       
        return await withCheckedContinuation { continuation in
            
            FirebaseReference(.Location).document(id).getDocument { documentSnapshot, error in
                                
                guard let document = documentSnapshot else {
                    continuation.resume(returning: nil)
                    return
                }

                let location = try? document.data(as: Location.self)
                
                continuation.resume(returning: location)
            }
        }
    }

    func listenForLocations() -> AnyPublisher<[Location], Error> {
        let subject = PassthroughSubject<[Location], Error>()
        
        FirebaseReference(.Location).addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                subject.send(completion: .failure(FirebaseError.badSnapshot))
                return
            }
            
            let locations = documents.compactMap {
                try? $0.data(as: Location.self)
            }
            subject.send(locations)
        }
        
        return subject.eraseToAnyPublisher()
    }

    
    

        
//    func saveLocation(_ location: Location) {
//
//        do {
//            try FirebaseReference(.Location).document(location.id).setData(from: location)
//        }
//        catch {
//            print("Error saving location", error.localizedDescription)
//        }
//    }
//
//    func deleteLocation(_ location: Speaker) {
//        FirebaseReference(.Location).document(location.id).delete()
//    }
}
