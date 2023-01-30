//
//  AdminSpeakerViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 15/01/2023.
//

import SwiftUI

final class AdminSpeakerViewModel: ObservableObject {
    
    func save(speaker: Speaker) {
        do {
            try FirebaseReference(.Speaker).document(speaker.id).setData(from: speaker)
        }
        catch {
            print("Error saving speaker", error.localizedDescription)
        }
    }
    
    func uploadAvatar() async {
        
    }

    func deleteSpeaker(_ speaker: Speaker) {
        FirebaseReference(.Speaker).document(speaker.id).delete()
    }
}

