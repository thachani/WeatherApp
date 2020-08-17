//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Tarek HACHANI on 17/08/2020.
//  Copyright © 2020 Tarek-HACHANI. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let reuseIdentifier = "WeatherTableViewCell"
    
    // MARK: - Properties
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    // MARK: - Public API

    func configure(withDay day: String, date: String, image: UIImage?, windSpeed: String, temperature: String) {
           // Configure Icon Image View
           iconImageView.image = image

           // Configure Labels
           dayLabel.text = day
           dateLabel.text = date
           windSpeedLabel.text = windSpeed
           temperatureLabel.text = temperature
       }
    
}
