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
    
    static let dummySession = Session(id: UUID().uuidString, title: "I love SwiftUI", content: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk)
    
    static let arrayOfSessions = [
        Session(id: UUID().uuidString, title: "I love SwiftUI and other things from Apple", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk)
    ]
}

