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

//    private var sut: BaseViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
        Container.Registrations.push()
        Container.setupMocks()
    }

    override func tearDown() {
        super.tearDown()
        Container.Registrations.pop()
    }


    func test_FetchingSpeakersReturnSix() async {
        //Given
        let expectation = XCTestExpectation(description: "waiting for network call")
        let sut = BaseViewModel()

        sut.$speakers
            .dropFirst()
            .sink { newValue in
                XCTAssertEqual(newValue.count, 6)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        Task {
            await sut.listenForSpeakers()
        }

        // Then
        wait(for: [expectation], timeout: 1)
    }

}
