//
//  ForecastsViewController.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

import UIKit

class ForecastsViewController: UIViewController, StoryboardInitializable {

    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: ForecastsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.6007251143, green: 0.8508604765, blue: 0.917899549, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
}

//MARK: - TableView Methods
extension ForecastsViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ForecastTableViewCell.nib, forCellReuseIdentifier: ForecastTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = ForecastTableViewCell.kEstimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let forecast = viewModel?.forecast(at: indexPath.row) else { return UITableViewCell() }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier:
            ForecastTableViewCell.reuseIdentifier, for: indexPath) as? ForecastTableViewCell {
            cell.populate(with: forecast)
            return cell
        }
        
        return UITableViewCell()
    }
}
