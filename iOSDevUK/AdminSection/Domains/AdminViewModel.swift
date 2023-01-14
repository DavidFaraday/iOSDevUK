//
//  AdminViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/10/2022.
//

import Foundation

final class AdminViewModel: ObservableObject {
    
    let firebaseAuth = FirebaseAuthentication.shared
    
    @Published var logoutError: Error?
    @Published var showError = false

    @MainActor
    func logOutUser() async {
        logoutError = await firebaseAuth.logOutUser()
        showError = logoutError != nil
    }

    
    //TODO: Move to firebase class
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
