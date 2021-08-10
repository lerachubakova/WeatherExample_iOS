//
//  MainViewController.swift
//  WeatherExample
//
//  Created by User on 6.08.21.
//

import PKHUD
import SkyFloatingLabelTextField
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var sunriseLabel: UILabel!
    @IBOutlet private weak var sunsetLabel: UILabel!
    @IBOutlet private weak var refreshBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var listButton: UIButton!
    
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
        temperatureLabel.text = weatherModel.temp.temp.toCelcium().getFormatString(f: ".1") + "°C"
        feelsLikeLabel.text = weatherModel.temp.feelsTemp.toCelcium().getFormatString(f: ".1") + "°C"
        pressureLabel.text = weatherModel.temp.pressure.getFormatString(f: "04") + "hPa"
        humidityLabel.text = weatherModel.temp.humidity.getFormatString(f: "02") + "%"
        sunriseLabel.text =  Date(timeIntervalSince1970: TimeInterval(weatherModel.sun.sunrise)).getFormatString(format: "HH:mm")
        sunsetLabel.text = Date(timeIntervalSince1970: TimeInterval(weatherModel.sun.sunset)).getFormatString(format: "HH:mm")
        refreshBarButtonItem.tintColor = .white
        listButton.isHidden = false
    }
    
    func configureScreen(with weatherModel: WeatherItem) {
        cityTextField.text = weatherModel.cityName
        descriptionLabel.text = weatherModel.mainDescription
        temperatureLabel.text = weatherModel.temperature.getFormatString(f: ".1") + "°C"
        feelsLikeLabel.text = weatherModel.feelsTemperature.getFormatString(f: ".1") + "°C"
        pressureLabel.text = weatherModel.pressure.getFormatString(f: "04") + "hPa"
        humidityLabel.text = weatherModel.humidity.getFormatString(f: "02") + "%"
        sunriseLabel.text = weatherModel.sunrise!.getFormatString(format: "HH:mm")
        sunsetLabel.text = weatherModel.sunset!.getFormatString(format: "HH:mm")
        refreshBarButtonItem.tintColor = .white
        listButton.isHidden = false
    }
    
    func cleanScreen() {
        refreshBarButtonItem.tintColor = .clear
        listButton.isHidden = true
    }
    
    func blockUI() {
        DispatchQueue.main.async { [unowned self] in
            HUD.show(.progress)
            view.isUserInteractionEnabled = false
        }
    }
    
    func enableUI(isSuccess: Bool) {
        DispatchQueue.main.async { [unowned self] in
            if isSuccess {
                HUD.flash(.success, delay: 0.5)
            } else {
                HUD.flash(.error, delay: 0.7)
            }
            view.isUserInteractionEnabled = true
        }
       
    }
    
    @IBAction private func tappedRefreshButton() {
        self.view.endEditing(true)
        viewModel.refresh()
    }
}
// MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            viewModel.weatherRequest(cityName: text)
        }
        return self.view.endEditing(true)
    }
}
