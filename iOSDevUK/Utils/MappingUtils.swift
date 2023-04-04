//
//  MappingUtils.swift
//  iOSDevUK
//
//  Created by David Kababyan on 02/04/2023.
//

import Foundation
import WeatherKit

protocol MappingUtilsProtocol {
    func convert(input: HourWeather) -> WeatherData
    func convert(input: CurrentWeather?) -> WeatherData?
}


class MappingUtils: MappingUtilsProtocol {
    
   func convert(input: HourWeather) -> WeatherData {
        
        WeatherData(
            tempDate: input.date,
            condition: input.condition.description,
            symbolName: input.symbolName,
            currentTempC: input.temperature.value,
            feelsLikeC: input.apparentTemperature.value
        )
    }
    func convert(input: CurrentWeather?) -> WeatherData? {
        guard let input = input else { return nil }
            
        return WeatherData(
            tempDate: input.date,
            condition: input.condition.description,
            symbolName: input.symbolName,
            currentTempC: input.temperature.value,
            feelsLikeC: input.apparentTemperature.value
        )
    }
}
