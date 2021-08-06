//
//  WeatherModel.swift
//  WeatherExample
//
//  Created by User on 6.08.21.
//

import Foundation

struct WeatherModel: Codable {
    let cod: Int
    let id: Int
    let timezone: Int
    let dt: Int
    let visibility: Int
    let name: String
    let base: String

    init(code: Int, id: Int, timezone: Int, visibility: Int, dt: Int, name: String, base: String) {
        self.cod = code
        self.id = id
        self.timezone = timezone
        self.dt = dt
        self.visibility = visibility
        self.name = name
        self.base = base
    }
}
