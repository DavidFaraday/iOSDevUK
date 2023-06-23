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
    static func setupMocks(objectsToReturn: [Codable], shouldReturnError: Bool = false) {
        Container.shared.firebaseRepository.register { MockFirebaseRepository(objectsToReturn: objectsToReturn, shouldReturnError: shouldReturnError) }
    }
}
