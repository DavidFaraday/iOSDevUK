//
//  FirebaseSponsorListener.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import Foundation
import FirebaseFirestoreSwift

class FirebaseSponsorListener {
    
    static let shared = FirebaseSponsorListener()
    
    private init () { }
    
    func getSponsors() async -> [Sponsor] {
       
        return await withCheckedContinuation { continuation in
            
            FirebaseReference(.Sponsor).getDocuments { querySnapshot, error in
                
                var sponsors: [Sponsor] = []
                
                guard let documents = querySnapshot?.documents else {
                    continuation.resume(returning: sponsors)
                    return
                }

                sponsors = documents.compactMap { (queryDocumentSnapshot) -> Sponsor? in
                    return try? queryDocumentSnapshot.data(as: Sponsor.self)
                }
                
                continuation.resume(returning: sponsors)
            }
        }
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
