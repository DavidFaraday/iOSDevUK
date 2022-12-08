//
//  iOSDevUKTests.swift
//  iOSDevUKTests
//
//  Created by David Kababyan on 08/12/2022.
//

import XCTest
import Factory
import Combine

@testable import iOSDevUK

final class iOSDevUKTests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        Container.Registrations.push()
        Container.setupMocks()
    }

    override func tearDownWithError() throws {
        Container.Registrations.pop()
    }

    func test_FetchSpeakerSessions_ReturnOne() {
        let sut = SpeakerDetailViewModel(speaker: DummyData.speakers[0])
        
        let expectation = expectation(description: "waiting for network call")
        
        sut.$sessions
            .dropFirst()
            .sink { newValue in
                XCTAssertEqual(newValue.count, 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        Task {
            await sut.getSpeakerSessions()
        }
        
        waitForExpectations(timeout: 0.1)
    }
}
