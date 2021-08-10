//
//  WeatherItem+CoreDataClass.swift
//  
//
//  Created by User on 10.08.21.
//
//

import Foundation
import CoreData

@objc(WeatherItem)
public class WeatherItem: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherItem> {
        return NSFetchRequest<WeatherItem>(entityName: "WeatherItem")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var feelsTemperature: Float
    @NSManaged public var humidity: Int32
    @NSManaged public var mainDescription: String?
    @NSManaged public var measurementDate: Date?
    @NSManaged public var pressure: Int32
    @NSManaged public var requestDate: Date?
    @NSManaged public var sunrise: Date?
    @NSManaged public var sunset: Date?
    @NSManaged public var temperature: Float
    
    func toString() -> String {
        var result = "\nWeatherItem: "
        result += "\n\tcityName: \(self.cityName!)"
        result += "\n\tmainDescription: \(self.mainDescription!)"
        result += "\n\tmeasurementDate: \(self.measurementDate!.getFormatString(format: "E, d MMM yyyy HH:mm:ss Z"))"
        result += "\n\trequestDate: \(self.requestDate!.getFormatString(format: "E, d MMM yyyy HH:mm:ss Z"))"
        result += "\n\ttemperature: \(self.temperature)"
        result += "\n\tfeelsTemperature: \(self.feelsTemperature)"
        result += "\n\thumidity: \(self.humidity)"
        result += "\n\tpressure: \(self.pressure)"
        result += "\n\tsunset: \(self.sunset!.getFormatString(format: "E, d MMM yyyy HH:mm:ss Z"))"
        result += "\n\tsunrise: \(self.sunrise!.getFormatString(format: "E, d MMM yyyy HH:mm:ss Z"))"
        return result
    }
}
