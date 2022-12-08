//
//  TestDataClass.swift
//  iOSDevUK
//
//  Created by David Kababyan on 08/12/2022.
//

import Foundation
import Factory

protocol TestDataProtocol {
    func fetchString() async -> String
}

final class TestData: TestDataProtocol {
    func fetchString() async -> String {
        "real string"
    }
}



final class MocTestData: TestDataProtocol {
    func fetchString() async -> String {
        "Moc string"
    }
}


final class TestViewModel: ObservableObject {
    
    func testMeaPlease() async {
        print("Called test me please func")
        
    }
}
