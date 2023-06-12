//
//  SessionRowViewModelTest.swift
//  iOSDevUKTests
//
//  Created by David Kababyan on 10/12/2022.
//

import XCTest
import Combine
import Factory

@testable import iOSDevUK

final class SessionRowViewModelTest: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func tearDownWithError() throws {
        cancellables = []
    }

    func test_InitialPropertyValuesAreNil() {
        Container.setupMocks(objectsToReturn: [DummyData.location])

        let sut = SessionRowViewModel()
        
        XCTAssertNil(sut.location)
        XCTAssertNil(sut.fetchError)
    }

    
    func test_fetchLocationWithoutId() {
        Container.setupMocks(objectsToReturn: [DummyData.location])

        let sut = SessionRowViewModel()
        
        Task {
            await sut.fetchLocation(with: nil)
        }
        
        XCTAssertNil(sut.location)
    }


    func test_fetchLocationReturnsLocation() async {
        Container.setupMocks(objectsToReturn: [DummyData.location])

        let sut = SessionRowViewModel()
        await sut.fetchLocation(with: "TestLocation123")

        
        sut.$location
            .dropFirst()
            .sink { newValue in
                XCTAssertNotNil(newValue)
                XCTAssertEqual(newValue?.id, "TestLocation123")
            }
            .store(in: &cancellables)
    }


    func test_fetchLocationReturnsError() async {
        Container.setupMocks(objectsToReturn: [DummyData.location], shouldReturnError: true)
        
        let sut = SessionRowViewModel()
        await sut.fetchLocation(with: "TestLocation123")
        
        sut.$fetchError
            .dropFirst()
            .sink { newValue in
                XCTAssertNotNil(newValue)
                XCTAssertEqual(newValue as? AppError, AppError.badSnapshot)
            }
            .store(in: &cancellables)
    }
}
