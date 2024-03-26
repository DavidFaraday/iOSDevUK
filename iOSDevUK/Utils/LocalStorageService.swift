//
//  LocalStorageService.swift
//  iOSDevUK
//
//  Created by David Kababyan on 12/08/2023.
//

import Foundation

protocol LocalStorageServiceProtocol {
    func save(items: [String], for key: String)
    func loadArray(with key: String) -> [String]
}

final class LocalStorageService: LocalStorageServiceProtocol {
    
    static let shared = LocalStorageService()
    
    private init() {}
    
    func save(items: [String], for key: String) {
        UserDefaults.standard.set(items, forKey: key)
    }
    
    func loadArray(with key: String) -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }
}
