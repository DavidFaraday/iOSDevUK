//
//  Sponsor.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import Foundation
import SwiftUI

enum SponsorCategory: String, Codable, Comparable, Hashable, CaseIterable {
    case Platinum, Gold, Silver
        
    var sortOrder: Int {
        switch self {
        case .Platinum:
            return 0
        case .Gold:
            return 1
        case .Silver:
            return 2
        }
    }
    
    var color: Color {
        switch self {
        case .Platinum:
            return Color(ColorNames.platinumColor)
        case .Gold:
            return Color(ColorNames.goldColor)
        case .Silver:
            return Color(ColorNames.silverColor)
        }
    }
    
    static func < (lhs: SponsorCategory, rhs: SponsorCategory) -> Bool {
        lhs.sortOrder < rhs.sortOrder
    }

}

struct Sponsor: Codable, Identifiable, Equatable, Hashable, Comparable {
    
    let id: String
    let name: String
    let tagline: String
    let url: String
    let urlText: String
    let sponsorCategory: SponsorCategory
    let imageLinkDark: String?
    let imageLinkLight: String?
    
    var imageUrlDark: URL? {
        URL(string: imageLinkDark ?? "")
    }
    var imageUrlLight: URL? {
        URL(string: imageLinkLight ?? "")
    }
    
    var webUrl: URL? {
        URL(string: url)
    }
    
    static func < (lhs: Sponsor, rhs: Sponsor) -> Bool {
        lhs.sponsorCategory < rhs.sponsorCategory
    }
    
    static func ==(lhs: Sponsor, rhs: Sponsor) -> Bool {
        lhs.id == rhs.id
    }
}
