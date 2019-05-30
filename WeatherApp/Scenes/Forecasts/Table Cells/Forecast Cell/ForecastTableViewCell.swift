//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    static let nib = UINib(nibName: "ForecastTableViewCell", bundle: nil)
    static let reuseIdentifier = "cellReuseIdentifier_ForecastTableViewCell"
    static let kEstimatedRowHeight: CGFloat = 80.0
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherStateImageView: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
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
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    private func setupTextAppearances() {
        dayLabel.font = UIFont.boldSystemFont(ofSize: 21)
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        temperatureLabel.font = UIFont.systemFont(ofSize: 30)
        
        dayLabel.adjustsFontSizeToFitWidth = true
        dateLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.adjustsFontSizeToFitWidth = true
    }
    
    func populate(with forecast: Forecast) {
        dayLabel.text = forecast.applicableDate.date?.dayName()
        dateLabel.text = forecast.applicableDate
        temperatureLabel.text = String(describing: forecast.minTemp.int).degreesFormatted()
        let imageURLString = "\(APIEndpoints.kStaticImageResourcePNG64)/\(forecast.weatherStateAbbr).png"
        if let imageURL = URL(string: imageURLString) {
            weatherStateImageView.sd_setImage(with: imageURL)
        }
    }
    
}
