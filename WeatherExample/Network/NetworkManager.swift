//
//  NetworkManager.swift
//  WeatherExample
//
//  Created by User on 9.08.21.
//

import Foundation

class NetworkManager {
    static let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=minsk&appid=d56b344d09f0de91f1df36c266fd49db")!
    
    static func makeWeatherRequest( completion: @escaping (ResponseModel?, WeatherResponseModel?) -> Void ) {
        var result: (ResponseModel?, WeatherResponseModel?)
      
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            if let data = data {
                result.0 = try? JSONDecoder().decode(ResponseModel.self, from: data)
                result.1 = try? JSONDecoder().decode(WeatherResponseModel.self, from: data)
                
                completion(result.0, result.1)
            }
        }.resume()
    }
}
