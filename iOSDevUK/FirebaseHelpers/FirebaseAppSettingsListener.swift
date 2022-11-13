//
//  FirebaseAppSettingsListener.swift
//  iOSDevUK
//
//  Created by David Kababyan on 13/11/2022.
//

import FirebaseFirestoreSwift
import Combine

final class FirebaseAppSettingsListener {
    
    static let shared = FirebaseAppSettingsListener()
    
    private init () { }
    
    func listenForInfoItems() -> AnyPublisher<[InformationItem], Error> {
        let subject = PassthroughSubject<[InformationItem], Error>()
        
        FirebaseReference(.InformationItem).addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                subject.send(completion: .failure(FirebaseError.badSnapshot))
                return
            }
            
            let infoItems = documents.compactMap {
                try? $0.data(as: InformationItem.self)
            }
            
            subject.send(infoItems)
        }
        
        return subject.eraseToAnyPublisher()
    }

    
    func saveInformationItem(_ item: InformationItem) {
        do {
            try FirebaseReference(.InformationItem).document(item.id).setData(from: item)
        }
        catch {
            print("Error saving info Item", error.localizedDescription)
        }
    }
}

