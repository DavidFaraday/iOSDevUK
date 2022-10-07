//
//  SessionRowViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/10/2022.
//

import SwiftUI

final class SessionRowViewModel: ObservableObject {
    @Published private(set) var session: Session
    @Published private(set) var location: Location?
    
    init(session: Session) {
        self.session = session
    }
    
    @MainActor
    @Sendable func fetchLocation() async {
        if location == nil {
            print("fetch location for row")
            self.location = DummyData.location
        }
    }
}
