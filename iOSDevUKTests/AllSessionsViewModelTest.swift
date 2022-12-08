//
//  AllSessionsViewModelTest.swift
//  iOSDevUKTests
//
//  Created by David Kababyan on 08/12/2022.
//

import XCTest
import Combine

@testable import iOSDevUK

final class AllSessionsViewModelTest: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_InitSetsSessions_ToTwo() {
        let sut = AllSessionsViewModel(sessions: DummyData.sessions)
        
        sut.$sessions
            .sink { newValue in
                XCTAssertEqual(newValue.count, 2)
            }
            .store(in: &cancellables)
    }
    
    
    @MainActor
    func test_SelectedDateGetsValue() {
        let sut = AllSessionsViewModel(sessions: DummyData.sessions)
        
        sut.$selectedDate
            .dropFirst()
            .sink { newValue in
                XCTAssertNotEqual(newValue, "")
            }
            .store(in: &cancellables)

        sut.setCurrentDate()
    }

    @MainActor
    func test_SelectedDateSetToToday() {
        let sut = AllSessionsViewModel(sessions: [DummyData.sessions[1]])
        
        sut.$selectedDate
            .dropFirst()
            .sink { newValue in
                XCTAssertEqual(newValue, Date().dateAndWeekDay)
            }
            .store(in: &cancellables)

        sut.setCurrentDate()
    }
    
    @MainActor
    func test_SelectedDateSetTo10Thu() {
        let sut = AllSessionsViewModel(sessions: [DummyData.sessions[0]])
        
        sut.$selectedDate
            .dropFirst()
            .sink { newValue in
                XCTAssertEqual(newValue, "10 Thu")
            }
            .store(in: &cancellables)

        sut.setCurrentDate()
    }
}
