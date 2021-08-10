//
//  WeatherModel.swift
//  WeatherExample
//
//  Created by User on 6.08.21.
//

import Foundation

struct WeatherResponseModel: Codable {
    let timezone: Int
    let date: Int
    let city: String
    let weather: [WeatherModel]
    let temp: TempWeatherModel
    let sun: SunWeatherModel
  
    private enum CodingKeys: String, CodingKey {
        case timezone = "timezone"
        case date = "dt"
        case city = "name"
        case weather = "weather"
        case temp = "main"
        case sun = "sys"
    }

    init() {
        self.timezone = 0
        self.date = 0
        self.city = ""
        self.weather = [WeatherModel()]
        self.temp = TempWeatherModel()
        self.sun = SunWeatherModel()
    }
    
    init(code: Int, id: Int, timezone: Int, visibility: Int, dt: Int, name: String, base: String, weather: [WeatherModel], temp: TempWeatherModel, sun: SunWeatherModel) {
        self.timezone = timezone
        self.date = dt
        self.city = name
        self.weather = weather
        self.temp = temp
        self.sun = sun
    }
    
    func toString() -> String {
        var result = "\n WeatherResponseModel"
        result += "\n City: \(self.city)"
        result += "\n Date: \(self.date)"
        result += "\n Weather: \n\(self.weather[0].toString())"
        result += "\n Temp: \n\(self.temp.toString())"
        result += "\n Sun: \n\(self.sun.toString())"
        return result
    }
}
