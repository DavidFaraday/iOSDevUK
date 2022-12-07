//
//  AppErrors.swift
//  iOSDevUK
//
//  Created by David Kababyan on 27/11/2022.
//

import Foundation

enum AppError: Error {
    case badSnapshot
    case unknownError
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badSnapshot:
            return NSLocalizedString("Please check your internet connection and try again.", comment: "App error")
        case .unknownError:
            return NSLocalizedString("Please try again later.", comment: "App error")
        }
    }
}
