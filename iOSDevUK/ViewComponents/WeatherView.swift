//
//  WeatherView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/03/2023.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()

    @State private var showHourlyData = false
    
    @ViewBuilder
    func hourlyView() -> some View {
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
    
    var body: some View {
        if let currentWeather = viewModel.currentWeather {
            
            VStack(alignment: .trailing) {
                HStack(spacing: 8) {
                    Spacer()
                    Image(systemName: currentWeather.symbolName)
                        .font(.system(size: 75))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.primary, Color.blue)

                    Text(currentWeather.isCelsius ? currentWeather.feelsLikeC.roundNearest().toCelsius : currentWeather.feelsLikeF.roundNearest().toFahrenheit)
                        .font(.system(size: 45))
                }
                .padding(.horizontal, 16)

                Text(currentWeather.condition)
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                
                if showHourlyData {
                    hourlyView()
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

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
