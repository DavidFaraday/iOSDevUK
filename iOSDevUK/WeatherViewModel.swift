//
//  WeatherViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/03/2023.
//

import Foundation
import WeatherKit
import CoreLocation


final class WeatherViewModel: ObservableObject {
    
    let weatherService = WeatherService()
    let location = CLLocation(latitude: 35.166348, longitude: 33.364576)
    
    @Published private(set) var weather: Weather?
    @Published private(set) var hourlyWeatherData: Forecast<HourWeather>?
    @Published private(set) var currentWeather: WeatherData?
    @Published private(set) var hourlyWeather: [WeatherData] = []
    
    init() {
        Task {
            await getWeather()
        }
        observerData()
    }
    
    func observerData() {
        $hourlyWeatherData
            .map( { $0?.map(convert) ?? [] })
            .assign(to: &$hourlyWeather)
        
        $weather
            .map( { convert(input: $0?.currentWeather) })
            .assign(to: &$currentWeather)
    }
    
    @MainActor
    private func getWeather() async {
        self.weather = try? await weatherService.weather(for: location)
        
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
                                             
        let query =  WeatherQuery.hourly(startDate: Date(), endDate: tomorrow)
        self.hourlyWeatherData = try? await weatherService.weather(for: location, including: query)
    }
}

struct WeatherData: Identifiable {
    var id = UUID().uuidString
    let lastCheck = Date()
    let tempDate: Date
    let humidity: Double
    let windSpeed: Double
    let condition: WeatherCondition
    let symbolName: String
    var isCelsius = true
    let currentTempC: Double
    let feelsLikeC: Double

    var currentTempF: Double {
        (currentTempC * 9/5) + 32
    }
    var feelsLikeF: Double {
        (currentTempC * 9/5) + 32
    }
}


//TODO: Put in utils
func convert(input: HourWeather) -> WeatherData {
    
    WeatherData(
        tempDate: input.date,
        humidity: input.humidity,
        windSpeed: input.wind.speed.converted(to: .kilometersPerHour).value,
        condition: input.condition,
        symbolName: input.symbolName,
        currentTempC: input.temperature.value,
        feelsLikeC: input.apparentTemperature.value
    )
}
func convert(input: CurrentWeather?) -> WeatherData? {
    guard let input = input else { return nil }
        
    return WeatherData(
        tempDate: input.date,
        humidity: input.humidity,
        windSpeed: input.wind.speed.converted(to: .kilometersPerHour).value,
        condition: input.condition,
        symbolName: input.symbolName,
        currentTempC: input.temperature.value,
        feelsLikeC: input.apparentTemperature.value
    )
}
