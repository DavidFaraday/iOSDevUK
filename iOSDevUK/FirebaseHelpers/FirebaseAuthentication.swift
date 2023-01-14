//
//  FirebaseAuthentication.swift
//  iOSDevUK
//
//  Created by David Kababyan on 14/01/2023.
//

import Foundation
import Firebase

class FirebaseAuthentication {

    static let shared = FirebaseAuthentication()
    
    private init() { }
    
    var hasCurrentUser: Bool {
        Auth.auth().currentUser != nil
    }
    
    func loginUserWith(email: String, password: String) async throws -> Bool {
        
        try await withCheckedThrowingContinuation { continuation in

            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {                     continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: true)
            }
        }
    }

    func logOutUser() async -> Error? {
        do {
            try Auth.auth().signOut()
            return nil
        } catch let error {
            return error
        }
    }
}



