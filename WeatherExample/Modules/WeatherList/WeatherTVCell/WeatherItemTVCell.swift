//
//  WeatherItemTVCell.swift
//  WeatherExample
//
//  Created by User on 10.08.21.
//

import UIKit

class WeatherItemTVCell: UITableViewCell {
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var requestDateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    static let identifier = "profileCell"
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: Self.self), bundle: Bundle.main)
    }
    
    func configure(with item: WeatherItem) {
        cityLabel.text = item.cityName
        requestDateLabel.text = item.requestDate?.getFormatString(format: "dd.MM.yyyy HH:mm")
        temperatureLabel.text = item.temperature.getFormatString(f: ".1") + "°C"
    }
}
