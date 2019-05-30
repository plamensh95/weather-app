//
//  ForecastDetailsViewController.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, StoryboardInitializable {
    
    @IBOutlet private weak var weatherStateImageView: UIImageView!
    @IBOutlet private weak var weatherStateLabel: UILabel!
    
    @IBOutlet private weak var temperaturesContainerView: UIView!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var nowTemperatureLabel: UILabel!
    @IBOutlet private weak var nowTemperatureView: UIView!
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        
        viewModel?.updateUI = { [weak self] forecast in
            DispatchQueue.main.async {
                self?.populateUI(with: forecast)
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.feedContent()
    }
    
    private func setupUI() {
        setupBackgroundAppearances()
        setupTextAppearances()
    }
    
    private func setupBackgroundAppearances() {
        view.backgroundColor = #colorLiteral(red: 0.6007251143, green: 0.8508604765, blue: 0.917899549, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        nowTemperatureView.backgroundColor = #colorLiteral(red: 0.9982376695, green: 0.9481393695, blue: 0.005767893046, alpha: 1)
        temperaturesContainerView.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        temperaturesContainerView.borderWidth = 4
    }
    
    private func setupTextAppearances() {
        weatherStateLabel.font = UIFont.systemFont(ofSize: 20)
        minTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 32)
        nowTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 32)
        maxTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 32)
    }
    
    private func populateUI(with forecast: Forecast) {
        weatherStateLabel.text = forecast.weatherStateName
        
        let imageURLString = "\(APIEndpoints.kStaticImageResourcePNG)/\(forecast.weatherStateAbbr).png"
        if let imageURL = URL(string: imageURLString) {
            weatherStateImageView.sd_setImage(with: imageURL)
        }
        
        minTemperatureLabel.text = String(describing: forecast.minTemp.int).degreesFormatted()
        nowTemperatureLabel.text = String(describing: forecast.theTemp.int).degreesFormatted()
        maxTemperatureLabel.text = String(describing: forecast.maxTemp.int).degreesFormatted()
    }
}

//MARK: - TableView Methods
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ForecastDetails.kDetailsCellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let detail = viewModel?.detail(at: indexPath.row) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastDetails.kDetailsCellIdentifier, for: indexPath)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = detail
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
}
