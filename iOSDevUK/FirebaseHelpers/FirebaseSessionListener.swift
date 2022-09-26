//
//  FirebaseSessionListener.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import Foundation
import FirebaseFirestoreSwift

class FirebaseSessionListener {
    
    static let shared = FirebaseSessionListener()
    
    private init () { }
    
    func getSessions() async -> [Session] {
       
        return await withCheckedContinuation { continuation in
            
            FirebaseReference(.Session).getDocuments { querySnapshot, error in
                
                var sessions: [Session] = []
                
                guard let documents = querySnapshot?.documents else {
                    continuation.resume(returning: sessions)
                    return
                }

                sessions = documents.compactMap { (queryDocumentSnapshot) -> Session? in
                    return try? queryDocumentSnapshot.data(as: Session.self)
                }
                
                continuation.resume(returning: sessions)
            }
        }
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
