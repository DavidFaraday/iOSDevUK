//
//  Bundle+Extensions.swift
//  iOSDevUK
//
//  Created by David Kababyan on 13/09/2022.
//

import Foundation

extension Bundle {
    public var appName: String { getInfo("CFBundleName")  }
    public var displayName: String { getInfo("CFBundleDisplayName") }
    public var language: String { getInfo("CFBundleDevelopmentRegion") }
    public var identifier: String { getInfo("CFBundleIdentifier") }
    public var copyright: String { getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n") }
    
    public var appBuild: String { getInfo("CFBundleVersion") }
    public var appVersionLong: String { getInfo("CFBundleShortVersionString") }
    
    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}


extension Bundle {
    
    func data(for filename: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: filename, withExtension: nil) else { return nil }
        
        return try? Data(contentsOf: url)
    }
}
