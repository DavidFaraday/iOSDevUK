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

struct Session: Codable, Identifiable, Hashable, Comparable {
    
    let id: String
    let title: String
    let content: String
    let startDate: Date
    let endDate: Date
    let locationId: String
    let speakerIds: [String]
    let type: SessionType
    
    var startingDay: String {
        startDate.dateAndWeekDay
    }
    
    var duration: String {
        "\(startDate.weekDayTime) - \(endDate.time)"
    }
    
    static func < (lhs: Session, rhs: Session) -> Bool {
        lhs.startDate < rhs.startDate
    }
}

