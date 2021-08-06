//
//  ResponseModel.swift
//  WeatherExample
//
//  Created by User on 6.08.21.
//

import Foundation

struct ResponseModel: Codable {
    let cod: Int
    let message: String

    init(code: Int, mes: String) {
        self.cod = code
        self.message = mes
    }
}
