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
    weak var controller: MainViewController?
    
    init(vc: MainViewController) {
        self.controller = vc
        if let weatherItem = CoreDataManager.getLastItem() {
            controller?.configureScreen(with: weatherItem)
            weatherRequest(cityName: weatherItem.cityName!)
        } else {
            controller?.cleanScreen()
        }
    }
    
    func weatherRequest(cityName: String) {
        controller?.blockUI()
        NetworkManager.makeWeatherRequest(cityName: cityName) { [unowned self] (responseMessage, weatherResponseModel) in
            if let response = responseMessage {
                print(" Code: \(response.code),\n Message: \(response.message)")
            }
            guard let weatherResponse = weatherResponseModel else {
                controller?.enableUI(isSuccess: false)
                return
            }
            self.weather.value = weatherResponse
            saveInCoreData(item: weatherResponse)
            controller?.enableUI(isSuccess: true)
        }
    }
    
    func refresh() {
        if let weatherItem = CoreDataManager.getLastItem() {
            weatherRequest(cityName: weatherItem.cityName!)
        }
    }
    
    private func saveInCoreData(item: WeatherResponseModel) {
        DispatchQueue.main.async {
            CoreDataManager.addItem(item)
        }
    }
}
