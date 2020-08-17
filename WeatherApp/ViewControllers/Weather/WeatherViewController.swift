//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Tarek HACHANI on 17/08/2020.
//  Copyright © 2020 Tarek-HACHANI. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - Properties

       @IBOutlet var dateLabel: UILabel!
       @IBOutlet var timeLabel: UILabel!
       @IBOutlet var windSpeedLabel: UILabel!
       @IBOutlet var temperatureLabel: UILabel!
       @IBOutlet var descriptionLabel: UILabel!
       @IBOutlet var iconImageView: UIImageView!

    // MARK: -

    var viewModel: WeatherViewModel

     init?(coder: NSCoder, viewModel: WeatherViewModel) {
           self.viewModel = viewModel
           super.init(coder: coder)
       }

       required init?(coder: NSCoder) {
           fatalError("You must create this view controller with a viewModel.")
       }


    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.updateView()
            }
        }
    }

    func updateView() {
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        windSpeedLabel.text = viewModel.windSpeed
        temperatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.description
        iconImageView.image = viewModel.image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
