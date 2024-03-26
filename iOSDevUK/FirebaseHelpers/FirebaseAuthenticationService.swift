//
//  FirebaseAuthentication.swift
//  iOSDevUK
//
//  Created by David Kababyan on 14/01/2023.
//

import Foundation
import Firebase

protocol FirebaseAuthenticationServiceProtocol {
    func hasCurrentUser() -> Bool
    func loginUserWith(email: String, password: String) async throws -> Bool
    func logOutUser() async throws
}

class FirebaseAuthenticationService: FirebaseAuthenticationServiceProtocol {
    
    static let shared = FirebaseAuthenticationService()
    
    private init() {}
    
    func hasCurrentUser() -> Bool {
        Auth.auth().currentUser != nil
    }
    
    func loginUserWith(email: String, password: String) async throws -> Bool {
        
        try await withCheckedThrowingContinuation { continuation in

            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: true)
            }
        }
    }

    func logOutUser() async throws {
        do {
            try Auth.auth().signOut()
        } catch  {
            throw error
        }
    }
}



