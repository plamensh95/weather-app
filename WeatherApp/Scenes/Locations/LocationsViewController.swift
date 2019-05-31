//
//  LocationsViewController.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController, StoryboardInitializable {

    @IBOutlet private weak var tableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(reloadContent), for: .valueChanged)
        return refreshControl
    }()
    
    var viewModel: LocationsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        setupVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.6007251143, green: 0.8508604765, blue: 0.917899549, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    private func setupVM() {
        viewModel?.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
        viewModel?.displayErrorMessage = { errorMessage in
            DispatchQueue.main.async {
                UIAlertController(title: Message.kErrorOccurred, message: errorMessage,
                                  defaultActionButtonTitle: Message.kOK, tintColor: .blue).show()
            }
        }
        viewModel?.feedContent()
    }
    
    @objc private func reloadContent() {
        viewModel?.feedContent()
    }
    
    private func navigateToForecastsScreen(with forecasts: [Forecast]) {
        let forecastsVC = ForecastsViewController.initFrom(storyboard: .Forecasts)
        forecastsVC.viewModel = ForecastsViewModel(forecasts: forecasts)
        navigationController?.pushViewController(forecastsVC)
    }
}

//MARK: - TableView Methods
extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.register(LocationTableViewCell.nib, forCellReuseIdentifier: LocationTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = LocationTableViewCell.kEstimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let location = viewModel?.location(at: indexPath.row) else { return UITableViewCell() }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier:
            LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell {
            cell.populate(with: location)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let forecasts = viewModel?.forecastsForLocation(at: indexPath.row) else { return }
        navigateToForecastsScreen(with: forecasts)
    }
}
