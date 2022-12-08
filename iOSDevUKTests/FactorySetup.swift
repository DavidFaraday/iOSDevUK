//
//  FactorySetup.swift
//  iOSDevUKTests
//
//  Created by David Kababyan on 08/12/2022.
//

import Foundation
import Factory
@testable import iOSDevUK

extension Container {
    static func setupMocks() {
        firebaseRepository.register(factory: { MocFirebaseRepository() })
    }
}
