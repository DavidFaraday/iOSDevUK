//
//  Session.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import Foundation

enum SessionType: Codable {
    case talk, workshop, lightningTalk
}

struct Session: Codable, Identifiable {
    let id: String
    let title: String
    let content: String
    let startDate: Date
    let endDate: Date
    let locationId: String
    let speakerIds: [String]
    let type: SessionType
    
    static let dummySession = Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk)
    
    static let arrayOfSessions = [
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk)
    ]
}

