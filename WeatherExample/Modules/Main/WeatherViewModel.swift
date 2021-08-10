//
//  WeatherViewModel.swift
//  WeatherExample
//
//  Created by User on 9.08.21.
//

import Bond
import Foundation

class WeatherViewModel {
    var weather = Observable<WeatherResponseModel>(WeatherResponseModel())
    weak var controller: ViewController?
    
    init(vc: ViewController) {
        self.controller = vc
        weatherRequest()
    }
    
    func weatherRequest() {
        NetworkManager.makeWeatherRequest { [unowned self] (responseMessage,weatherResponseModel) in
            if let response = responseMessage {
                print("code: \(response.code), message: \(response.message)")
            }
            guard let weatherResponse = weatherResponseModel else { return }
            print(weatherResponse.toString())
            self.weather.value = weatherResponse
            saveInCoreData()
            // TODO: controller. function enable UI
        }
    }
    
    private func saveInCoreData() {
        // TODO: savi in core data
    }
}
