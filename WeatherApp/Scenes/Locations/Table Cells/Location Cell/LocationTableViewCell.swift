//
//  LocationTableViewCell.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    static let nib = UINib(nibName: "LocationTableViewCell", bundle: nil)
    static let reuseIdentifier = "cellReuseIdentifier_LocationTableViewCell"
    static let kEstimatedRowHeight: CGFloat = 130.0
    
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var parentLocationLabel: UILabel!
    @IBOutlet private weak var weatherStateLabel: UILabel!
    @IBOutlet private weak var weatherStateImageView: UIImageView!
    
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var nowTemperatureLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var nowTemperatureView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        setupBackgroundAppearances()
        setupTextAppearances()
    }
    
    private func setupBackgroundAppearances() {
        selectionStyle = .none
        backgroundColor = .clear
        nowTemperatureView.cornerRadius = nowTemperatureView.width / 2
        
        nowTemperatureView.borderWidth = 4
        nowTemperatureView.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        nowTemperatureView.backgroundColor = #colorLiteral(red: 0.9982376695, green: 0.9481393695, blue: 0.005767893046, alpha: 1)
    }
    
    private func setupTextAppearances() {
        locationLabel.font = UIFont.boldSystemFont(ofSize: 36)
        parentLocationLabel.font = UIFont.systemFont(ofSize: 14)
        weatherStateLabel.font = UIFont.systemFont(ofSize: 14)
        minTemperatureLabel.font = UIFont.systemFont(ofSize: 24)
        nowTemperatureLabel.font = UIFont.systemFont(ofSize: 36)
        maxTemperatureLabel.font = UIFont.systemFont(ofSize: 24)
    }
    
    func populate(with location: Location) {
        locationLabel.text = location.title
        parentLocationLabel.text = location.parent.title
        
        guard let forecast = location.consolidatedWeather.first else { return }
        
        weatherStateLabel.text = forecast.weatherStateName
        minTemperatureLabel.text = String(describing: forecast.minTemp.int).degreesFormatted()
        nowTemperatureLabel.text = String(describing: forecast.theTemp.int).degreesFormatted()
        maxTemperatureLabel.text = String(describing: forecast.maxTemp.int).degreesFormatted()
        
        //- TODO: Add images for weather state to project and show the image corresponding to the weather state
    }
}
