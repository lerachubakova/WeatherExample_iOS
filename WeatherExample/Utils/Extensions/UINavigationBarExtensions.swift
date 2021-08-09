//
//  UINavigationBarExtensions.swift
//  WeatherExample
//
//  Created by User on 9.08.21.
//

import UIKit

extension UINavigationBar {
    func transparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
    }
}
