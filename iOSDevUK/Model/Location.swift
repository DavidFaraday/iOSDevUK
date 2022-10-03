//
//  Location.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

//enum LocationType: Codable {
//    case au, transport, ev, pubs, sm
//}

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
    
    static let dummyLocation = Location(name: "Great Hall", note: "Some notes about the location", imageLink: "https://picsum.photos/200", latitude: 52.416120, longitude: -4.083800, locationTypeRecordName: "pub", webLink: WebLink.dummyLink)
}

struct WebLink: Codable {
    let recordName: String?
    let name: String?
    let url: String?
    
    static let dummyLink = WebLink(recordName: "Google", name: "google", url: "https://google.com")
}
