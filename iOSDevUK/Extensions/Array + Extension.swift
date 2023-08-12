//
//  Array + Extension.swift
//  iOSDevUK
//
//  Created by David Kababyan on 12/08/2023.
//

import Foundation

extension Array {
    func at(_ index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
}
