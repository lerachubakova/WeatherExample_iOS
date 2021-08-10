//
//  CoreDataManager.swift
//  WeatherExample
//
//  Created by User on 10.08.21.
//

import CoreData
import UIKit

class CoreDataManager {
    private static let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private static let debugDescription: String = "<Sparqly.CoreDataManager>"
    
    static func addItem(_ weather: WeatherResponseModel) {
        let newWeatherItem = WeatherItem(context: context)
        
        newWeatherItem.cityName = weather.city
        newWeatherItem.mainDescription = weather.weather[0].description.capitalizeFirstLetter()
        
        newWeatherItem.measurementDate = Date(timeIntervalSince1970: TimeInterval(weather.date))
        newWeatherItem.requestDate = Date()
        
        newWeatherItem.temperature = weather.temp.temp.toCelcium()
        newWeatherItem.feelsTemperature = weather.temp.feelsTemp.toCelcium()
        
        newWeatherItem.humidity = Int32(weather.temp.humidity)
        newWeatherItem.pressure = Int32(weather.temp.pressure)
    
        newWeatherItem.sunrise = Date(timeIntervalSince1970: TimeInterval( weather.sun.sunrise))
        newWeatherItem.sunset = Date(timeIntervalSince1970: TimeInterval( weather.sun.sunset))

        print(newWeatherItem.toString())
        do {
            context.insert(newWeatherItem)
            try context.save()
        } catch (let error) {
            print("### \(self.debugDescription): addItem: \(error)")
        }
    }
    
    static func getLastItem() -> WeatherItem? {
        let items = getItemsFromContext()
        if !items.isEmpty { return items.first }
        return nil
    }
    
    static private func getItemsFromContext() -> [WeatherItem] {
        let request = WeatherItem.fetchRequest() as NSFetchRequest<WeatherItem>
        if var items = try? context.fetch(request) {
            items.sort(by: {$0.requestDate!.compare($1.requestDate!).rawValue == 1})
            // items.map { print($0.toString()) }
            return items
        }
        return []
    }
    
}
