//
//  FirebaseSponsorListener.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import Combine
import Foundation
import FirebaseFirestoreSwift

class FirebaseSponsorListener {
    
    static let shared = FirebaseSponsorListener()
    
    private init () { }
    
    func listenForSponsors() -> AnyPublisher<[Sponsor], Error> {
        let subject = PassthroughSubject<[Sponsor], Error>()
        
        FirebaseReference(.Sponsor).addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                subject.send(completion: .failure(FirebaseError.badSnapshot))
                return
            }
            
            let sponsors = documents.compactMap {
                try? $0.data(as: Sponsor.self)
            }
            subject.send(sponsors)
        }
        
        return subject.eraseToAnyPublisher()
    }

    
    func saveSponsor(_ sponsor: Sponsor) {
        
        do {
            try FirebaseReference(.Sponsor).document(sponsor.id).setData(from: sponsor)
        }
        catch {
            print("Error saving sponsor", error.localizedDescription)
        }
    }
    
    func deleteSponsor(_ sponsor: Sponsor) {
        FirebaseReference(.Sponsor).document(sponsor.id).delete()
    }
}
