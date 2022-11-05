//
//  String + Extensions.swift
//  iOSDevUK
//
//  Created by David Kababyan on 30/10/2022.
//

import Foundation

extension String {
    var removeDigits: String {
        self.components(separatedBy: CharacterSet.decimalDigits).joined()
    }
}
