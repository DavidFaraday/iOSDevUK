//
//  WeatherView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/03/2023.
//

import SwiftUI

struct WeatherView: View {
    private var currentWeather: WeatherData
    private var hourlyWeather: [WeatherData]
    private var didTap: () -> Void
    
    init(currentWeather: WeatherData, hourlyWeather: [WeatherData], didTapWeather: @escaping () -> Void) {
        self.currentWeather = currentWeather
        self.hourlyWeather = hourlyWeather
        self.didTap = didTapWeather
    }
    
    @ViewBuilder
    func hourlyView() -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 15) {
                ForEach(hourlyWeather) { data in
                    VStack(spacing: 5) {
                        Text(data.tempDate.formatted(date: .omitted, time: .shortened))
                        HStack {
                            Image(systemName: data.symbolName)
                            Text(data.feelsLikeC.roundNearest().toCelsius)
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding([.leading, .top])
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Spacer()
                Image(systemName: currentWeather.symbolName)
                    .font(.system(size: 50))
                Text(currentWeather.isCelsius ? currentWeather.feelsLikeC.roundNearest().toCelsius : currentWeather.feelsLikeF.roundNearest().toFahrenheit)
                    .font(.system(size: 35))
            }
            .padding(.horizontal, 16)

            Text(currentWeather.condition.rawValue.capitalized)
                .font(.headline)
                .padding(.horizontal, 16)
            
            hourlyView()
        }
        .frame(height: 150)
        .onTapGesture {
            didTap()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(currentWeather: DummyData.weatherData, hourlyWeather: Array(repeating: DummyData.weatherData, count: 5)) {
        }
    }
}
