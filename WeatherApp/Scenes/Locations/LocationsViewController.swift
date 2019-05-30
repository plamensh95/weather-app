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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.6007251143, green: 0.8508604765, blue: 0.917899549, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }

}

//MARK: - TableView Methods
extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationTableViewCell.nib, forCellReuseIdentifier: LocationTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = LocationTableViewCell.kEstimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:
            LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell {
            return cell
        }
        
        return UITableViewCell()
    }
    
}
