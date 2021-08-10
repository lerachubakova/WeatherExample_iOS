//
//  NetworkManager.swift
//  WeatherExample
//
//  Created by User on 9.08.21.
//

import Foundation

final class NetworkManager {
    private static let defaultSession = URLSession(configuration: .default)
    private static var dataTask: URLSessionDataTask?
    
    static func makeWeatherRequest(cityName: String, completion: @escaping (ResponseModel?, WeatherResponseModel?) -> Void ) {
        guard !cityName.isEmpty, var urlComponents = URLComponents(string: APIConstants.baseURL) else { return }
        
        urlComponents.queryItems =
            [URLQueryItem(name: APIConstants.nameСity, value: cityName),
             URLQueryItem(name: APIConstants.nameID, value: APIConstants.valueID)]
        
        guard let url = urlComponents.url else { return }
            
        dataTask = defaultSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("\n Error: \(error!.localizedDescription)")
                return
            }
            
            // debug
            if response != nil {
                print("\n", response!.debugDescription)
            }
            
            if let data = data {
                let responseMessage = try? JSONDecoder().decode(ResponseModel.self, from: data)
                let weather = try? JSONDecoder().decode(WeatherResponseModel.self, from: data)
    
                completion(responseMessage, weather)
            }
        }
        
        dataTask?.resume()
    }
}
