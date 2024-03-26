//
//  WeatherView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/03/2023.
//

import SwiftUI
import WeatherKit

struct WeatherView: View {
    @EnvironmentObject var locationManager: LocationService
    @StateObject var viewModel = WeatherViewModel(weatherService: WeatherService())
    
    @State private var showHourlyData = false
    @State private var isCelsius = true
    
    @ViewBuilder
    func currentWeatherView(_ currentWeather: WeatherData) -> some View {
        
        HStack(spacing: 10) {
            
            Image(systemName: currentWeather.symbolName)
                .font(.system(size: 40))
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.primary, Color(.purple200))
            
            VStack(alignment: .leading) {
                Text(AppStrings.aberystwyth)
                    .semiboldAppFont(size: 18)
                
                Text(currentWeather.condition)
                    .appFont(size: 14)
            }
            .foregroundStyle(Color(.mainText))
            
            Spacer()
            
            Text(isCelsius ? currentWeather.feelsLikeC.roundNearest().toCelsius : currentWeather.feelsLikeF.roundNearest().toFahrenheit)
                .appFont(size: 40)
        }
    }
    
    @ViewBuilder
    func hourlyWeatherView() -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 15) {
                
                ForEach(viewModel.hourlyWeather) { data in
                    HourlyWeatherView(weatherData: data, isCelsius: isCelsius)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    func weatherTitleView() -> some View {
        HStack {
            Text("WEATHER")
                .semiboldAppFont(size: 12)
                .foregroundStyle(Color(.textGrey))
            
            Spacer()
            
            Button {
                withAnimation{isCelsius.toggle()}
            } label: {
                Text(isCelsius ? "°F" : "°C")
                    .semiboldAppFont(size: 15)
                    .foregroundColor(.white)
                    .padding(5)
                    .background {
                        Circle()
                            .fill(Color(.purple200))
                    }
            }
        }
    }
    
    @ViewBuilder
    func main() -> some View {
        VStack {
            if let currentWeather = viewModel.currentWeather {
                
                VStack(alignment: .leading, spacing: 10) {
                    weatherTitleView()
                    
                    currentWeatherView(currentWeather)
                    
                    if showHourlyData {
                        hourlyWeatherView()
                    }
                }
                .onTapGesture {
                    withAnimation {
                        showHourlyData.toggle()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    var body: some View {
        main()
            .task {
                viewModel.setLocation(location: MapDetails.defaultLocationAberystwyth)
                await viewModel.getWeather()
            }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
