//
//  TempWeatherModel.swift
//  WeatherExample
//
//  Created by User on 9.08.21.
//

import Foundation

struct TempWeatherModel: Codable {
    let temp: Float
    let feelsTemp: Float
    let pressure: Int
    let humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsTemp = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
    }
    
    init() {
        self.temp = 0.0
        self.feelsTemp = 0.0
        self.pressure = 0
        self.humidity = 0
    }

    init(temp: Float, feelsTemp: Float, pressure: Int, humidity: Int) {
        self.temp = temp
        self.feelsTemp = feelsTemp
        self.pressure = pressure
        self.humidity = humidity
    }
    
    func toString() -> String {
        var result = "\ttemp: \(self.temp.toCelcium())"
        result += "\n\tfeelsTemp: \(self.feelsTemp.toCelcium())"
        result += "\n\tpressure: \(self.pressure)"
        result += "\n\thumidity: \(self.humidity)"
        return result
    }
}
