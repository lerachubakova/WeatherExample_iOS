//
//  StringExtensions.swift
//  WeatherExample
//
//  Created by User on 9.08.21.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
