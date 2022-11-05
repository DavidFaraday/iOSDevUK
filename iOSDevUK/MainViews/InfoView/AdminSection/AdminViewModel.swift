//
//  AdminViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/10/2022.
//

import Foundation
import FirebaseFirestoreSwift

final class AdminViewModel {
    
    func save(speaker: Speaker) {

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
