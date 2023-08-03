//
//  String + Extensions.swift
//  iOSDevUK
//
//  Created by David Kababyan on 30/10/2022.
//

import Foundation

extension String {
    var removeDigits: String {
        components(separatedBy: CharacterSet.decimalDigits).joined()
    }

    var removeSpaces: String {
        self.replacingOccurrences(of: " ", with: "")
    }
}
