//
//  WeatherView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/03/2023.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var locationManager: LocationService
    @StateObject var viewModel = WeatherViewModel()
    
    @State private var showHourlyData = false
    
    @ViewBuilder
    func currentWeatherView(_ currentWeather: WeatherData) -> some View {
        HStack(spacing: 8) {
            Spacer()
            Image(systemName: currentWeather.symbolName)
                .font(.system(size: 75))
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.primary, Color.blue)
            
            Text(currentWeather.feelsLikeC.roundNearest().toCelsius)
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
                    
                    VStack(spacing: 5) {
                        Text(data.tempDate.formatted(date: .omitted, time: .shortened))
                        HStack {
                            Image(systemName: data.symbolName)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(Color.primary, Color.blue)
                            
                            Text(data.feelsLikeC.roundNearest().toCelsius)
                        }
                    }
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
            .task { viewModel.setLocation(location: locationManager.locationManager?.location) }
            .task(viewModel.getWeather)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
