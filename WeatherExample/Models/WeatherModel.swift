//
//  WeatherModel.swift
//  WeatherExample
//
//  Created by User on 9.08.21.
//

import Foundation

struct WeatherModel: Codable {
    let main: String
    let description: String
    
    init() {
        self.main = ""
        self.description = ""
    }
    
    init(main: String, description:String, iconURL: String) {
        self.main = main
        self.description = description
    }
    
    func toString() -> String {
        var result = "\tmain: \(self.main)"
        result += "\n\tdescription: \(self.description.capitalizeFirstLetter())"
        return result
    }
}
