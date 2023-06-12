//
//  ServiceDependencies.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/11/2022.
//

import Foundation
import Factory

extension Container {
    
    var firebaseRepository: Factory<FirebaseRepositoryProtocol> {
        self { FirebaseRepository() }
            .shared
    }

    var firebaseAuthRepository: Factory<FirebaseAuthenticationServiceProtocol> {
        self { FirebaseAuthenticationService() }
            .shared
    }
    
    var mappingUtils: Factory<MappingUtilsProtocol> {
        self { MappingUtils() }
            .shared
    }
}
