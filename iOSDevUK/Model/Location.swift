//
//  Location.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI


func locationName(from: String) -> String {
    switch from {
    case "au":
        return "Aberystwyth University"
    case "transport":
        return "Transport"
    case "ev":
        return "EV"
    case "pubs":
        return "Pubs"
    case "sm":
        return "Supermarket"
    default:
        return ""
    }
}

struct LocationObject: Codable {
    let locations: [Location]
}

struct Location: Codable, Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let note: String
    let imageLink: String?
    let latitude: Double
    let longitude: Double
    let locationTypeRecordName: String
    let webLink: WebLink?
}

struct WebLink: Codable {
    let recordName: String?
    let name: String?
    let url: String?
}
