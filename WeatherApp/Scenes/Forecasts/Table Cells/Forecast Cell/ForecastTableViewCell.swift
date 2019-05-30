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
    static let kEstimatedRowHeight: CGFloat = 60.0
    
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
        dayLabel.font = UIFont.boldSystemFont(ofSize: 26)
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        temperatureLabel.font = UIFont.systemFont(ofSize: 26)
    }
    
    func populate(with forecast: Forecast) {
        dayLabel.text = forecast.applicableDate.date?.dayName()
        dateLabel.text = forecast.applicableDate
        temperatureLabel.text = String(describing: forecast.minTemp.int).degreesFormatted()
    }
    
}
