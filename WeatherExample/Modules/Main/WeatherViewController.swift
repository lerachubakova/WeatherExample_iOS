//
//  WeatherViewController.swift
//  WeatherExample
//
//  Created by User on 6.08.21.
//

import PKHUD
import SkyFloatingLabelTextField
import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet private weak var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var sunriseLabel: UILabel!
    @IBOutlet private weak var sunsetLabel: UILabel!
    @IBOutlet private weak var refreshBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var measureDateLabel: UILabel!
    @IBOutlet private weak var requestDateLabel: UILabel!
    
    @IBOutlet private weak var listButton: UIButton!
    
    private var viewModel: WeatherViewModel!
    
    private var isMain = true
    private var weatherItem: WeatherItem?
    
    func setScreenTypeNotMain(weatherItem: WeatherItem) {
        isMain = false
        self.weatherItem = weatherItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isMain {
            viewModel = WeatherViewModel(vc: self)
            bindWeatherViewModel()
        } else {
            viewModel = WeatherViewModel(vc: self, weatherItem: weatherItem!)
        }
        self.navigationController?.setNavigationBarHidden(!isMain, animated: false)
        self.navigationController?.navigationBar.transparent()
        self.cityTextField.textAlignment = .center
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
        measureDateLabel.isHidden = false
        measureDateLabel.text = "Measure Date " + Date(timeIntervalSince1970: TimeInterval(weatherModel.date)).getFormatString(format: "dd.MM.yyyy HH:mm")
        requestDateLabel.isHidden = true
        refreshBarButtonItem.tintColor = .white
        listButton.isHidden = false
    }
    
    func configureScreen(with weatherModel: WeatherItem, isMainScreen: Bool = true) {
        cityTextField.text = weatherModel.cityName
        if !isMainScreen {
            cityTextField.lineHeight = 0
            requestDateLabel.isHidden = false
            requestDateLabel.text = "Request Date " + weatherModel.requestDate!.getFormatString(format: "dd.MM.yyyy HH:mm")
            listButton.isHidden = true
        } else {
            requestDateLabel.isHidden = true
            listButton.isHidden = false
        }
        descriptionLabel.text = weatherModel.mainDescription
        temperatureLabel.text = weatherModel.temperature.getFormatString(f: ".1") + "°C"
        feelsLikeLabel.text = weatherModel.feelsTemperature.getFormatString(f: ".1") + "°C"
        pressureLabel.text = weatherModel.pressure.getFormatString(f: "04") + "hPa"
        humidityLabel.text = weatherModel.humidity.getFormatString(f: "02") + "%"
        sunriseLabel.text = weatherModel.sunrise!.getFormatString(format: "HH:mm")
        sunsetLabel.text = weatherModel.sunset!.getFormatString(format: "HH:mm")
        measureDateLabel.isHidden = false
        measureDateLabel.text = "Measure Date " + weatherModel.measurementDate!.getFormatString(format: "dd.MM.yyyy HH:mm")
        refreshBarButtonItem.tintColor = .white
    }
    
    func cleanScreen() {
        refreshBarButtonItem.tintColor = .clear
        listButton.isHidden = true
        requestDateLabel.isHidden = true
        measureDateLabel.isHidden = true
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
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            viewModel.weatherRequest(cityName: text)
        }
        return self.view.endEditing(true)
    }
}
