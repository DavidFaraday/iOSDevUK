//
//  Speaker.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import Foundation

struct Weblink: Codable {
    let name: String
    let link: String
}

struct Speaker: Codable, Identifiable {
    let id: String
    let name: String
    let biography: String
    let linkedIn: String
    let twitterId: String
    let imageLink: String
    let webLinks: [Weblink]?
}
