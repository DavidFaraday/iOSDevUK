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
    let humidity: Double
    let windSpeed: Double
    let condition: String
    let symbolName: String
    var isCelsius = true
    let currentTempC: Double
    let feelsLikeC: Double
    
    var humidityString: String {
        "\((humidity * 100).roundDown())%"
    }
    
    var windSpeedString: String {
        "\(windSpeed.roundDown())km/h"
    }

    var currentTempF: Double {
        (currentTempC * 9/5) + 32
    }
    var feelsLikeF: Double {
        (currentTempC * 9/5) + 32
    }
}
