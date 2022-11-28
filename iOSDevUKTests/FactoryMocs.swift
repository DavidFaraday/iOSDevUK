//
//  FactoryMocs.swift
//  iOSDevUKTests
//
//  Created by David Kababyan on 27/11/2022.
//


import Factory
import Foundation

@testable import iOSDevUK

extension Container {
    static func setupMocks() {
        print("setting up mocs")
        firebaseRepository.register { MocFirebaseRepository() }
    }
}
