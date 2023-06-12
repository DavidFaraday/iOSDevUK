//
//  SessionDetailViewModelTest.swift
//  iOSDevUKTests
//
//  Created by David Kababyan on 11/12/2022.
//

import XCTest
import Combine
import Factory

@testable import iOSDevUK

final class SessionDetailViewModelTest: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []

    override func tearDownWithError() throws {
        cancellables = []
    }

    func test_InitialPropertyValuesAreNil() {

        let sut = SessionDetailViewModel(sessionId: "")
        
        XCTAssertNil(sut.location)
        XCTAssertNil(sut.session)
        XCTAssertNil(sut.speakers)
        XCTAssertNil(sut.fetchError)
        XCTAssertFalse(sut.showError)
    }

    func test_FetchSessionReturnsError() {
        Container.setupMocks(objectsToReturn: [DummyData.sessions[0]], shouldReturnError: true)
        
        let expectation = expectation(description: "Waiting for session")
        let sut = SessionDetailViewModel(sessionId: "Session123")

        sut.$fetchError
            .dropFirst()
            .sink { newValue in
                XCTAssertNotNil(newValue)
                XCTAssertEqual(newValue as? AppError, AppError.badSnapshot)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        Task {
            await sut.fetchSession()
        }
        
        waitForExpectations(timeout: 0.1)
    }
    
    
    func test_FetchSessionSetsSessionValue() {
        Container.setupMocks(objectsToReturn: [DummyData.sessions[0]])

        let expectation = expectation(description: "Waiting for session")
        let sut = SessionDetailViewModel(sessionId: "Session123")
        
        sut.$session
            .dropFirst()
            .sink { newValue in
                XCTAssertNotNil(newValue)
                XCTAssertEqual(newValue?.id, "Session123")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        Task {
           await sut.fetchSession()
        }
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_FetchSpeakerSetsSpeakerValue() {

        Container.setupMocks(objectsToReturn: [DummyData.speakers[0]])
        
        let speakerExpectation = expectation(description: "Waiting for speaker")
        
        let sut = SessionDetailViewModel(sessionId: "Session123", session: DummyData.sessions[0])
        
        sut.$speakers
            .dropFirst()
            .drop(while: { $0!.count < 1 })
            .sink { newValue in
                XCTAssertNotNil(newValue)
                XCTAssertEqual(newValue?.first?.id, "Speaker1ID")
                speakerExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        Task {
            await sut.fetchSpeakers()
        }
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_FetchSpeakerExitWhileSessionIsNil() {

        Container.setupMocks(objectsToReturn: [DummyData.speakers[0]])
        
        let speakerExpectation = expectation(description: "Waiting for speaker")
        
        let sut = SessionDetailViewModel(sessionId: "Session123")
        
        
        Task {
            await sut.fetchSpeakers()
        }
        
        XCTAssertNil(sut.speakers)
        speakerExpectation.fulfill()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_FetchLocationSetsSpeakerValue() {

        Container.setupMocks(objectsToReturn: [DummyData.location])
        
        let speakerExpectation = expectation(description: "Waiting for speaker")
        
        let sut = SessionDetailViewModel(sessionId: "Session123", session: DummyData.sessions[0])
        
        sut.$location
            .dropFirst()
            .sink { newValue in
                XCTAssertNotNil(newValue)
                XCTAssertEqual(newValue?.id, "TestLocation123")
                speakerExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        Task {
            await sut.fetchLocation()
        }
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_FetchLocationExitWhileSessionIsNil() {

        Container.setupMocks(objectsToReturn: [DummyData.location])
        
        let speakerExpectation = expectation(description: "Waiting for speaker")
        
        let sut = SessionDetailViewModel(sessionId: "Session123")
        
        
        Task {
            await sut.fetchSpeakers()
        }
        
        XCTAssertNil(sut.location)
        speakerExpectation.fulfill()
        
        waitForExpectations(timeout: 0.1)
    }

    @MainActor
    func test_ResetErroSetsErrorToNil() {
        let sut = SessionDetailViewModel(sessionId: "Session123")

        sut.resetError()
        
        XCTAssertNil(sut.fetchError)
    }

}
