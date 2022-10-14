//
//  FirebaseHomeListener.swift
//  iOSDevUK
//
//  Created by David Kababyan on 14/10/2022.
//

import Foundation
import FirebaseFirestoreSwift
import Combine

class FirebaseHomeListener {
    
    struct MessageString: Codable {
        let message: String
    }
    
    static let shared = FirebaseHomeListener()
    
    private init () { }
    
    func listenForNotification() -> AnyPublisher<String, Error> {
        let subject = PassthroughSubject<String, Error>()
        
        FirebaseReference(.Home).document("EventNotification").addSnapshotListener { documentSnapshot, error in
            
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }

            guard let document = documentSnapshot else {
                subject.send(completion: .failure(FirebaseError.badSnapshot))
                return
            }
            
            let notification = try? document.data(as: MessageString.self)

            subject.send(notification?.message ?? "")
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func listenForAboutString() -> AnyPublisher<String, Error> {
        let subject = PassthroughSubject<String, Error>()
        
        FirebaseReference(.Home).document("AboutString").addSnapshotListener { documentSnapshot, error in
            
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            guard let document = documentSnapshot else {
                subject.send(completion: .failure(FirebaseError.badSnapshot))
                return
            }
            
            let notification = try? document.data(as: MessageString.self)
            
            subject.send(notification?.message ?? "")
        }
        
        return subject.eraseToAnyPublisher()
    }
}



