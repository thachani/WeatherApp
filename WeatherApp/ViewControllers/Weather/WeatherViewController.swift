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

    @IBOutlet var tableView: UITableView!

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

        setupTableView()

        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.updateView()
            }
        }
    }

    func setupTableView() {
        tableView.rowHeight = 110
        registerCells()
    }

    func registerCells() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "WeatherTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: WeatherTableViewCell.reuseIdentifier)

    }


    func updateView() {
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        windSpeedLabel.text = viewModel.windSpeed
        temperatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.description
        iconImageView.image = viewModel.image

        tableView.reloadData()
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

extension WeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow(forSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseIdentifier, for: indexPath) as? WeatherTableViewCell else {
            fatalError("Unable to Dequeue WeatherTableViewCell")
        }

        let date = viewModel.dailyWeatherDateForCell(atIndex: indexPath)
        let day = viewModel.dailyWeatherDayForCell(atIndex: indexPath)
        let image = viewModel.dailyWeatherIconForCell(atIndex: indexPath)
        let temperature = viewModel.dailyWeatherTempForCell(atIndex: indexPath)
        let windSpeed = viewModel.dailyWeatherWindSpeedForCell(atIndex: indexPath)
        cell.configure(withDay: day, date: date, image: image, windSpeed: windSpeed, temperature: temperature)

        return cell
    }
}
