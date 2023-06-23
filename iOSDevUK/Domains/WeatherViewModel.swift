//
//  WeatherViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/03/2023.
//

import Foundation
import WeatherKit
import CoreLocation
import Factory

final class WeatherViewModel: ObservableObject {
    @Injected(\.mappingUtils) private var mappingUtils
    
    @Published private var weather: Weather?
    @Published private var hourlyWeatherData: Forecast<HourWeather>?
    @Published private(set) var currentWeather: WeatherData?
    @Published private(set) var hourlyWeather: [WeatherData] = []
    
    let weatherService: WeatherService
    var location: CLLocation?
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
        observerData()
    }
    
    private func observerData() {
        $hourlyWeatherData
            .map( { $0?.map(self.mappingUtils.convert) ?? [] })
            .assign(to: &$hourlyWeather)
        
        $weather
            .map( { self.mappingUtils.convert(input: $0?.currentWeather) })
            .assign(to: &$currentWeather)
    }
    
    @MainActor
    @Sendable func getWeather() async {
        guard let location = location else { return }
        guard weather == nil else { return }
        
        self.weather = try? await weatherService.weather(for: location)
                                                     
        let query =  WeatherQuery.hourly(startDate: Date(), endDate: Date().tomorrow)
        self.hourlyWeatherData = try? await weatherService.weather(for: location, including: query)
    }
    
    func setLocation(location: CLLocation?) {
        self.location = location
    }
}
