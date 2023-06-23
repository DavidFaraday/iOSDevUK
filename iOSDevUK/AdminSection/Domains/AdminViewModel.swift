//
//  AdminViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/10/2022.
//

import Foundation
import Factory

final class AdminViewModel: ObservableObject {
    @Injected(\.firebaseAuthRepository) private var firebaseAuth
    
    @Published var logoutError: Error?
    @Published var showError = false

    @MainActor
    func logOutUser() async {
        do {
            try await firebaseAuth.logOutUser()
        } catch (let error) {
            logoutError = error
        }
        
        showError = logoutError != nil
    }
}
