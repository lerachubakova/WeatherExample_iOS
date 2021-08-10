//
//  ViewController.swift
//  WeatherExample
//
//  Created by User on 6.08.21.
//

import SkyFloatingLabelTextField
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var sunriseLabel: UILabel!
    @IBOutlet private weak var sunsetLabel: UILabel!
    
    private var viewModel: WeatherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WeatherViewModel(vc: self)
        self.navigationController?.navigationBar.transparent()
        bindWeatherViewModel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func bindWeatherViewModel() {
        _ =  viewModel.weather.observeNext(with: { [unowned self] weatherModel in
            guard weatherModel.city != "" else { return }
            DispatchQueue.main.async {
                self.configureScreen(with: weatherModel)
            }
        })
    }
    
    private func configureScreen(with weatherModel: WeatherResponseModel) {
        cityTextField.text = weatherModel.city
        descriptionLabel.text = weatherModel.weather[0].description.capitalizeFirstLetter()
        temperatureLabel.text = weatherModel.temp.temp.toCelcium().format(f: ".1") + "°C"
        feelsLikeLabel.text = weatherModel.temp.feelsTemp.toCelcium().format(f: ".1") + "°C"
        pressureLabel.text = weatherModel.temp.pressure.format(f: "04") + "hPa"
        humidityLabel.text = weatherModel.temp.humidity.format(f: "02") + "%"
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(weatherModel.sun.sunrise))
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(weatherModel.sun.sunset))
        sunriseLabel.text = sunriseDate.getFormatString(format: "HH:mm")
        sunsetLabel.text = sunsetDate.getFormatString(format: "HH:mm")
    }
    
    func enableUI() {
        // TODO: enable UI
        // TODO: off krutiolka
    }
    
    @IBAction private func tappedRefreshButton() {
        viewModel.weatherRequest(cityName: cityTextField.text ?? "Gomel")
        // TODO: downloading PKHUD && block UI
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.weatherRequest(cityName: textField.text ?? "Gomel")
        return self.view.endEditing(true)
    }
}
