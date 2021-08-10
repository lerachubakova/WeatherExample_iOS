//
//  WeatherListViewController.swift
//  WeatherExample
//
//  Created by User on 10.08.21.
//

import UIKit

class WeatherListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: WeatherListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WeatherListViewModel(vc: self)
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherItemTVCell.nib(), forCellReuseIdentifier: WeatherItemTVCell.identifier)
    }
    
    func reloadTable() {
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
}
// MARK: - UITableViewDelegate
 extension WeatherListViewController: UITableViewDelegate {
    
 }

// MARK: - UITableViewDataSource
 extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: WeatherItemTVCell.identifier) as? WeatherItemTVCell {
            itemCell.selectionStyle = .none
            itemCell.configure(with: viewModel.weatherItems[indexPath.row])
            return itemCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trashAction = UIContextualAction(style: .destructive, title: nil) { [unowned self] (_, _, completionHandler) in
            self.viewModel.deleteItem(index: indexPath.row)
            completionHandler(true)
        }
        trashAction.image = UIImage(systemName: "trash.fill")
        trashAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [trashAction])
    }
 }
