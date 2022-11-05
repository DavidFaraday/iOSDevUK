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
    
    
    func getSpeaker(with id: String) async -> Speaker? {
        
        return await withCheckedContinuation { continuation in
            
            FirebaseReference(.Speaker).document(id).getDocument { documentSnapshot, error in

                guard let document = documentSnapshot else {
                    continuation.resume(returning: nil)
                    return
                }
                
                let speaker = try? document.data(as: Speaker.self)
                continuation.resume(returning: speaker)
            }
        }
    }
}
