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
    let sity: String
    let weather: [WeatherModel]
    let temp: TempWeatherModel
    let sun: SunWeatherModel
  
    private enum CodingKeys: String, CodingKey {
        case timezone = "timezone"
        case date = "dt"
        case sity = "name"
        case weather = "weather"
        case temp = "main"
        case sun = "sys"
    }

    init() {
        self.timezone = 0
        self.date = 0
        self.sity = ""
        self.weather = [WeatherModel()]
        self.temp = TempWeatherModel()
        self.sun = SunWeatherModel()
    }
    
    init(code: Int, id: Int, timezone: Int, visibility: Int, dt: Int, name: String, base: String, weather: [WeatherModel], temp: TempWeatherModel, sun: SunWeatherModel) {
        self.timezone = timezone
        self.date = dt
        self.sity = name
        self.weather = weather
        self.temp = temp
        self.sun = sun
    }
    
    func toString() -> String {
        var result = "city: \(self.sity)"
        result += "\ndate: \(Date(timeIntervalSince1970: TimeInterval(self.date)).getFormatString(format: "E, d MMM yyyy HH:mm:ss Z"))"
        result += "\nweather: \n\(self.weather[0].toString())"
        result += "\ntemp: \n\(self.temp.toString())"
        result += "\nsun: \n\(self.sun.toString())"
        return result
    }
}
