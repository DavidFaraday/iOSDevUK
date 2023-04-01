//
//  Double + Extensions.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/03/2023.
//

import Foundation

extension Double {

    var toCelsius: String {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        return formatter.string(from: Measurement(value: self, unit: UnitTemperature.celsius))
    }
    
    var toFahrenheit: String {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: Measurement(value: self, unit: UnitTemperature.fahrenheit))
    }
    
    func roundNearest() -> Double {
        (self * 2).rounded() / 2
    }
    
    func roundDown() -> String {
        self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    
}
