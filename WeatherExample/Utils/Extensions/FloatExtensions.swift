//
//  FloatExtensions.swift
//  WeatherExample
//
//  Created by User on 9.08.21.
//

import Foundation

extension Float {
    func toCelcium() -> Float {
        return self - 273.15
    }
    
    func getFormatString(f: String) -> String {
        // .3 = "0.000"
        // .1 = "0.0"
        return String(format: "%\(f)f", self)
    }
    
}
