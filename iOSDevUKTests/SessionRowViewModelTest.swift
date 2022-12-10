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

    override func setUpWithError() throws {
        Container.Registrations.push()
    }

    override func tearDownWithError() throws {
        Container.Registrations.pop()
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


    func test_fetchLocationReturnsLocation() {
        Container.setupMocks(objectsToReturn: [DummyData.location])

        let expectation = expectation(description: "Waiting for location")
        
        let sut = SessionRowViewModel()
        
        sut.$location
            .dropFirst()
            .sink { newValue in
                XCTAssertNotNil(newValue)
                XCTAssertEqual(newValue?.id, "TestLocation123")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        
        Task {
            await sut.fetchLocation(with: "TestLocation123")
        }
        
        waitForExpectations(timeout: 0.1)
    }



    func test_fetchLocationReturnsError() {
        Container.setupMocks(objectsToReturn: [DummyData.location], shouldReturnError: true)

        let expectation = expectation(description: "Waiting for location")
        
        let sut = SessionRowViewModel()
        
        sut.$fetchError
            .dropFirst()
            .sink { newValue in
                XCTAssertNotNil(newValue)
                XCTAssertEqual(newValue as? AppError, AppError.badSnapshot)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        
        Task {
            await sut.fetchLocation(with: "TestLocation123")
        }
        
        waitForExpectations(timeout: 0.1)
    }


}
