//
//  Sponsor.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import Foundation

enum SponsorCategory: String, Codable {
    case Platinum
    case Gold
    case Silver
}

struct Sponsor: Codable, Identifiable {
    let id: String
    let name: String
    let tagline: String
    let url: String?
    let urlText: String?
    let sponsorCategory: SponsorCategory
    let imageLink: String?
}
