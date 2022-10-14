//
//  FirebaseSessionListener.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import Foundation
import FirebaseFirestoreSwift
import Combine

enum FirebaseError: Error {
    case badSnapshot
}

class FirebaseSessionListener {
    
    static let shared = FirebaseSessionListener()
    
    private init () { }
    
    func getSessions() -> AnyPublisher<[Session], Error> {
        let subject = PassthroughSubject<[Session], Error>()
        
        FirebaseReference(.Speaker).addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                subject.send(completion: .failure(FirebaseError.badSnapshot))
                return
            }
            
            let sessions = documents.compactMap {
                try? $0.data(as: Session.self)
            }
            
            subject.send(sessions)
        }
        
        return subject.eraseToAnyPublisher()
    }

        
    func saveSession(_ session: Session) {
        
        do {
            try FirebaseReference(.Session).document(session.id).setData(from: session)
        }
        catch {
            print("Error saving session", error.localizedDescription)
        }
    }
    
    func deleteSession(_ session: Session) {
        FirebaseReference(.Session).document(session.id).delete()
    }
}
