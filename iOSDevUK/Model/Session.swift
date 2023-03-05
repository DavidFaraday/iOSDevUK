//
//  Session.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import Foundation

enum SessionType: Codable, CaseIterable {
    case talk, workshop, lightningTalk
    
    var name: String {
        switch self {
        case .talk:
            return "Talk"
        case .workshop:
            return "Workshop"
        case .lightningTalk:
            return "Lightning Talk"
        }
    }
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

