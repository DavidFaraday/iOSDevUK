//
//  WeatherData.swift
//  iOSDevUK
//
//  Created by David Kababyan on 01/04/2023.
//

import Foundation

struct WeatherData: Identifiable {
    var id = UUID().uuidString
    let lastCheck = Date()
    let tempDate: Date
    let condition: String
    let symbolName: String
    
    let currentTempC: Double
    let feelsLikeC: Double

    var currentTempF: Double {
        (currentTempC * 9/5) + 32
    }
    var feelsLikeF: Double {
        (currentTempC * 9/5) + 32
    }
}
