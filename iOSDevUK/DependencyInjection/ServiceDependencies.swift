//
//  ServiceDependencies.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/11/2022.
//

import Foundation
import Factory

extension Container {
    static let firebaseRepository = Factory<FirebaseRepositoryProtocol>(scope: .shared) {
        return FirebaseRepository()
    }
    
    static let firebaseAuthRepository = Factory<FirebaseAuthenticationServiceProtocol>(scope: .shared) {
        return FirebaseAuthenticationService()
    }
    
    static let mappingUtils = Factory<MappingUtilsProtocol>(scope: .shared) {
        return MappingUtils()
    }
}
