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
}
