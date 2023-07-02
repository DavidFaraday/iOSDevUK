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
    static func pinForLocationFetcher(_ locationType: LocationType) -> String
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
    
    static func pinForLocationFetcher(_ locationType: LocationType) -> String {
            switch locationType {
            case .au: return ImageNames.MapIcons.book
            case .ev: return ImageNames.MapIcons.plug
            case .other: return ImageNames.MapIcons.mapPin
            case .pubs: return ImageNames.MapIcons.mug
            case .sm: return ImageNames.MapIcons.basket
            case .transport: return ImageNames.MapIcons.car
            }
        }
}
