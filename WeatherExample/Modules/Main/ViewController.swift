//
//  ViewController.swift
//  WeatherExample
//
//  Created by User on 6.08.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    }
    
    func makeRequest() {
        let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=minsk&appid=d56b344d09f0de91f1df36c266fd49db")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
     
//            guard let httpResponse = response as? HTTPURLResponse else { return }
//
//            print(httpResponse.statusCode)

            if let data = data {
                if let response = try? JSONDecoder().decode(ResponseModel.self, from: data) {
                    print(response)
                }
                if let weather = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                    print(weather)
                } else {
                    print("Something with weather went wrong")
                }
            }
        }.resume()
    }
}
