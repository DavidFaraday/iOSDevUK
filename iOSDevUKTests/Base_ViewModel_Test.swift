//
//  Base_ViewModel_Test.swift
//  iOSDevUKTests
//
//  Created by David Kababyan on 27/11/2022.
//

import XCTest
import Factory
import Combine
@testable import iOSDevUK



final class Base_ViewModel_Test: XCTestCase {

    private var sut: SpeakerDetailViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        Container.Registrations.push()
//        Container.setupMocks()
        sut = SpeakerDetailViewModel(speaker: DummyData.speaker)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        super.tearDown()
        Container.Registrations.pop()
    }


    func test_FetchingSpeakersReturnSix() async {
        Container.firebaseRepository.register(factory: { MocFirebaseRepository() } )
        //Given
        let expectation = XCTestExpectation(description: "waiting for network call")

        sut.$sessions
            .dropFirst()
            .sink { newValue in
                XCTAssertEqual(newValue.count, 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        Task {
            await sut.getSpeakerSessions()
        }

        // Then
        wait(for: [expectation], timeout: 1)
    }

}
