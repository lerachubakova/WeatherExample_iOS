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
        weatherRequest(cityName: "Brest") // last from CoreData
    }
    
    func weatherRequest(cityName: String) {
        NetworkManager.makeWeatherRequest(cityName: cityName) { [unowned self] (responseMessage,weatherResponseModel) in
            if let response = responseMessage {
                print(" Code: \(response.code),\n Message: \(response.message)")
            }
            guard let weatherResponse = weatherResponseModel else { return }
            print(weatherResponse.toString())
            self.weather.value = weatherResponse
            saveInCoreData()
            // TODO: controller. function enable UI
        }
    }
    
    private func saveInCoreData() {
        // TODO: save in core data
    }
}
