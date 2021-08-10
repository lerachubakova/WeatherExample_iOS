//
//  ResponseModel.swift
//  WeatherExample
//
//  Created by User on 6.08.21.
//

import Foundation

struct ResponseModel: Codable {
    let code: Int
    let message: String

    private enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message = "message"
    }
    
    init(code: Int, mes: String) {
        self.code = code
        self.message = mes
    }
}
