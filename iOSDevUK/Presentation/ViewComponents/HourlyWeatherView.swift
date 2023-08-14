//
//  HourlyWeatherView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 02/04/2023.
//

import SwiftUI

struct HourlyWeatherView: View {
    
    private let weatherData: WeatherData
    private let isCelsius: Bool
    
    init(weatherData: WeatherData, isCelsius: Bool) {
        self.weatherData = weatherData
        self.isCelsius = isCelsius
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Text(weatherData.tempDate.formatted(date: .omitted, time: .shortened))
            HStack {
                Image(systemName: weatherData.symbolName)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.primary, Color.blue)
                
                Text(isCelsius ? weatherData.feelsLikeC.roundNearest().toCelsius : weatherData.feelsLikeF.roundNearest().toFahrenheit)
            }
        }
    }
}

struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeatherView(weatherData: DummyData.weatherData, isCelsius: true)
    }
}
