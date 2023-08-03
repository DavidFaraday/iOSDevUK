//
//  Session.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import Foundation

enum SessionType: String, Codable, CaseIterable {
    case talk, workshop, lightningTalk, social, lunch, coffeeBiscuits, dinner, registration
    
    var name: String {
        switch self {
        case .talk:
            return "Talk"
        case .workshop:
            return "Workshop"
        case .lightningTalk:
            return "Lightning Talk"
        case .social:
            return "Social"
        case .lunch:
            return "Lunch"
        case .coffeeBiscuits:
            return "Coffee Biscuits"
        case .dinner:
            return "Dinner"
        case .registration:
            return "Registration"
        }
    }
}

struct Session: Codable, Identifiable, Hashable, Comparable {
    
    let id: String
    let title: String
    let content: String
    let startDate: Date
    let endDate: Date
    let locationId: String?
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

