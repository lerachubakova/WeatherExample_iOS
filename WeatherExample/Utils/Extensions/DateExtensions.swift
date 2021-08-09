//
//  DateExtensions.swift
//  WeatherExample
//
//  Created by User on 9.08.21.
//

import Foundation

extension Date {
    func getFormatString(format: String) -> String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = format
         return dateFormatter.string(for: self) ?? ""
    }
}
