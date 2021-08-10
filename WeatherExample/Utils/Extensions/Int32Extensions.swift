//
//  Int32Extensions.swift
//  WeatherExample
//
//  Created by User on 10.08.21.
//

import Foundation

extension Int32 {
    func getFormatString(f: String) -> String {
        // 03 = "000"
        // 05 = "00000"
        return String(format: "%\(f)d", self)
    }
}
