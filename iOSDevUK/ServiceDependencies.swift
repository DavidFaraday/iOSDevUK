//
//  ServiceDependencies.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/11/2022.
//

import Foundation
import Factory

extension Container {
    static let firebaseRepository = Factory<FirebaseRepositoryProtocol>(scope: .singleton) {
        return FirebaseRepository()
    }
}
