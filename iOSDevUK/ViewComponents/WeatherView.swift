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
        Text(AppStrings.aberystwyth)
            .font(.headline)
            .padding(.horizontal, 16)
        HStack(spacing: 8) {
            
            Button {
                withAnimation{isCelsius.toggle()}
            } label: {
                ZStack {
                    Circle()
                        .fill(Color(ColorNames.secondary))
                        .frame(width: 30)
                    Text(isCelsius ? "°F" : "°C")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            Image(systemName: currentWeather.symbolName)
                .font(.system(size: 75))
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.primary, Color.blue)
            
            Text(isCelsius ? currentWeather.feelsLikeC.roundNearest().toCelsius : currentWeather.feelsLikeF.roundNearest().toFahrenheit)
                .font(.system(size: 45))
        }
        .padding(.horizontal, 16)
        
        Text(currentWeather.condition)
            .font(.subheadline)
            .padding(.horizontal, 16)
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
        .padding([.leading, .top])
    }
    
    func main() -> some View {
        VStack {
            
            if let currentWeather = viewModel.currentWeather {
                
                VStack(alignment: .trailing) {
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
    }
    
    var body: some View {
        main()
            .task { viewModel.setLocation(location: MapDetails.defaultLocationAberystwyth) }
            .task(viewModel.getWeather)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .environmentObject(LocationService.shared)
    }
}
