//
//  NavigationRouter.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/11/2022.
//

import Foundation

final class NavigationRouter: ObservableObject {
    @Published var homePath: [Destination] = []
    @Published var schedulePath: [Destination] = []
    @Published var attendeePath: [Destination] = []
    @Published var infoPath: [Destination] = []
}


enum Destination: Hashable {
    case speaker(Speaker)
    case speakers([Speaker])
    case session(Session)
    case sessions([Session])
    case sponsor
    case locations([Location])
    case savedSession(SavedSession)
}
