//
//  InformationItem.swift
//  iOSDevUK
//
//  Created by David Kababyan on 06/10/2022.
//

import Foundation

struct InformationItem: Codable, Identifiable, Comparable {
    
    let id: String
    let name: String
    let link: String
    
    static func < (lhs: InformationItem, rhs: InformationItem) -> Bool {
        lhs.name < rhs.name
    }
}
