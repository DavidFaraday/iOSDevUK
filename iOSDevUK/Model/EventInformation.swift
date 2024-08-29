//
//  EventInformation.swift
//  iOSDevUK
//
//  Created by David Kababyan on 25/11/2022.
//

import Foundation

struct EventInformation: Codable, Identifiable {
    let id: String
    let about: String
    let notification: String
    let startDate: Date
    let endDate: Date
    let inclusivityText: String
}
