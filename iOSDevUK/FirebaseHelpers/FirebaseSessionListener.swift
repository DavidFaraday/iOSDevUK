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
    
    func listenForSessions() -> AnyPublisher<[Session], Error> {
        let subject = PassthroughSubject<[Session], Error>()
        
        FirebaseReference(.Session).addSnapshotListener { querySnapshot, error in
            
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

//    func getSessionsOfSpeaker(with id: String) async -> [Session] {
//
//        return await withCheckedContinuation { continuation in
//
//            FirebaseReference(.Session).whereField("speakerIds", arrayContains: id).getDocuments { querySnapshot, error in
//
//                var sessions: [Session] = []
//
//                guard let documents = querySnapshot?.documents else {
//                    continuation.resume(returning: sessions)
//                    return
//                }
//
//                sessions = documents.compactMap { (queryDocumentSnapshot) -> Session? in
//                    return try? queryDocumentSnapshot.data(as: Session.self)
//                }
//
//                continuation.resume(returning: sessions)
//            }
//        }
//    }

//    func getSession(with id: String) async -> Session? {
//
//        return await withCheckedContinuation { continuation in
//
//            FirebaseReference(.Session).document(id).getDocument { documentSnapshot, error in
//
//                guard let document = documentSnapshot else {
//                    continuation.resume(returning: nil)
//                    return
//                }
//
//                let session = try? document.data(as: Session.self)
//
//                continuation.resume(returning: session)
//            }
//        }
//    }

        
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
