//
//  FirebasePresenterListener.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import Foundation
import FirebaseFirestoreSwift
import Combine

class FirebaseSpeakerListener {
    
    static let shared = FirebaseSpeakerListener()
    
    private init () { }
    
    func getSpeakers() -> AnyPublisher<[Speaker], Error> {
        let subject = PassthroughSubject<[Speaker], Error>()
        
        FirebaseReference(.Speaker).addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                subject.send(completion: .failure(FirebaseError.badSnapshot))
                return
            }
            
            let speakers = documents.compactMap {
                try? $0.data(as: Speaker.self)
            }
            
            subject.send(speakers)
        }
        
        return subject.eraseToAnyPublisher()
    }

    
//    func getSpeakers() async -> [Speaker] {
//       
//        return await withCheckedContinuation { continuation in
//            
//            FirebaseReference(.Speaker).getDocuments { querySnapshot, error in
//                
//                var speakers: [Speaker] = []
//                
//                guard let documents = querySnapshot?.documents else {
//                    continuation.resume(returning: speakers)
//                    return
//                }
//
//                speakers = documents.compactMap { (queryDocumentSnapshot) -> Speaker? in
//                    return try? queryDocumentSnapshot.data(as: Speaker.self)
//                }
//                
//                continuation.resume(returning: speakers)
//            }
//        }
//    }
        
    func saveSpeaker(_ speaker: Speaker) {
        
        do {
            try FirebaseReference(.Speaker).document(speaker.id).setData(from: speaker)
        }
        catch {
            print("Error saving speaker", error.localizedDescription)
        }
    }
    
    func deleteSpeaker(_ speaker: Speaker) {
        FirebaseReference(.Speaker).document(speaker.id).delete()
    }
}
