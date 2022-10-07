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

//not needed for the app, used only to get locations from JSON and save to Firebase
struct LocationObject: Codable {
    let locations: [Location]
}

struct Location: Codable, Identifiable {
    let id: String
    let name: String
    let note: String
    let imageLink: String?
    let latitude: Double
    let longitude: Double
    let locationTypeRecordName: String
    let webLink: Weblink?
//    let locationType: LocationType
}

enum LocationType: Codable {
    case au
    case transport
    case ev
    case pubs
    case sm
}

