//
//  LoginViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 14/01/2023.
//

import SwiftUI
import Factory

final class LoginViewModel: ObservableObject {
    @Injected(\.firebaseAuthRepository) private var firebaseAuth

    @Published var loginSuccessful = false
    @Published var loginError: Error?
    @Published var showError = false
    
    @MainActor
    func loginUserWith(email: String, password: String) async {
        do {
            loginSuccessful = try await firebaseAuth.loginUserWith(email: email, password: password)
        } catch (let error) {
            loginError = error
            showError = true
        }
    }
}

