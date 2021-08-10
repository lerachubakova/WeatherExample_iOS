//
//  WeatherModel.swift
//  WeatherExample
//
//  Created by User on 9.08.21.
//

import Foundation

struct WeatherModel: Codable {
    let description: String
    
    init() {
        self.description = ""
    }
    
    init(main: String, description:String, iconURL: String) {
        self.description = description
    }
    
    func toString() -> String {
        "\tdescription: \(self.description)"
    }
}
