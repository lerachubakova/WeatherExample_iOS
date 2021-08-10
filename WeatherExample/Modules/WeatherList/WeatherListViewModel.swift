//
//  WeatherListViewModel.swift
//  WeatherExample
//
//  Created by User on 10.08.21.
//
import Bond
import Foundation

class WeatherListViewModel {
    var weatherItems: MutableObservableArray<WeatherItem>
    
    private weak var controller: WeatherListViewController?
    
    init(vc: WeatherListViewController) {
        self.controller = vc
        weatherItems = MutableObservableArray<WeatherItem>(CoreDataManager.getItemsFromContext())
    }
    
    private func refreshItems() {
        let items = CoreDataManager.getItemsFromContext()
        weatherItems = MutableObservableArray<WeatherItem>(items)
    }
    
    func deleteItem(index: Int) {
        CoreDataManager.deleteItemFromContext(item: weatherItems[index])
        refreshItems()
        controller?.reloadTable()
    }
    
}
