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

    
    func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            print("logged in with ", authResult?.user.email)
            completion(error)
        }
    }

    func logOutUser(completion: @escaping(_ error: Error?) -> Void) {
        
        do {
            try Auth.auth().signOut()
            
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
    }

}



