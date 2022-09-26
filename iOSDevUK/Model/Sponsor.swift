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
    
    static let dummySponsor = Sponsor(id: UUID().uuidString, name: "Aberystwyth University", tagline: "Aberystwyth University has a Computer Science department with excellent research, producing graduates with strong technical skills. Talk to us about how we can work together to get our graduates working for your company.", url: "https://www.aber.ac.uk/en/cs/", urlText: "Aber Comp Sci Website", sponsorCategory: .Gold, imageLink: "https://picsum.photos/200/300")
}
