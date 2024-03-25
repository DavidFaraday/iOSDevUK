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
    var removeChars: String {
        components(separatedBy: CharacterSet.letters).joined()
    }

    var removeSpaces: String {
        self.replacingOccurrences(of: " ", with: "")
    }
}
