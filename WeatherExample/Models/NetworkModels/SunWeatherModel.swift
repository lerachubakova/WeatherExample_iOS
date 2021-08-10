//
//  SunWeatherModel.swift
//  WeatherExample
//
//  Created by User on 9.08.21.
//

import Foundation

struct SunWeatherModel: Codable {
    let sunrise: Int
    let sunset: Int
    
    init() {
        self.sunrise = 0
        self.sunset = 0
    }

    init( sunrise: Int, sunset: Int) {
        self.sunrise = sunrise
        self.sunset = sunset
    }
    
    func toString() -> String {
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(sunrise))
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(sunset))
        var result = "\tsunrise: \(sunriseDate.getFormatString(format: "E, d MMM yyyy HH:mm:ss Z"))"
        result += "\n\tsunset: \(sunsetDate.getFormatString(format: "E, d MMM yyyy HH:mm:ss Z"))"
        return result
    }
}
