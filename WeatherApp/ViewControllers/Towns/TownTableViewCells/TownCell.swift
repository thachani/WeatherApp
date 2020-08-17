//
//  TownCell.swift
//  WeatherApp
//
//  Created by Tarek HACHANI on 17/08/2020.
//  Copyright © 2020 Tarek-HACHANI. All rights reserved.
//

import UIKit

class TownCell: UITableViewCell {
    static let reuseIdentifier = "TownCell"

    // MARK: - Properties

    @IBOutlet  var headerLabel: UILabel!

    // MARK: - Configuration

    func configure(withTitle title: String) {
        headerLabel.text = title
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
