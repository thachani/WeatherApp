//
//  ViewController.swift
//  WeatherApp
//
//  Created by Tarek HACHANI on 16/08/2020.
//  Copyright © 2020 Tarek-HACHANI. All rights reserved.
//

import UIKit

class TownsListViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var tableView: UITableView!
    var viewModel: TownsListViewModel = TownsListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupTableView()
        title = "TOWNS"
    }

    func setupTableView() {
        tableView.rowHeight = 44.0
        registerCells()
    }

    func registerCells() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TownCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: TownCell.reuseIdentifier)

    }

    @IBAction func addTownTapped(_ sender: Any) {
        guard let addTownVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTownViewControllerStrId") as? AddTownViewController else {
            fatalError("Cannot instantiate AddTownViewController ")
        }

        addTownVC.delegate = self
        navigationController?.pushViewController(addTownVC, animated: true)

    }
}

extension TownsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow(forSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TownCell.reuseIdentifier, for: indexPath) as? TownCell else {
            fatalError("Unable to Dequeue Town Table View Cell")
        }

        let title = viewModel.titleForCell(atIndex: indexPath)
        cell.configure(withTitle: title)

        return cell
    }
}

extension TownsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let weatherVM = viewModel.getWeatherViewModel(forIndexPath: indexPath)

//MARK: - inject dependencies with storyboard instance is available only for ios13
        
        if #available(iOS 13.0, *) {
            let weatherVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WeatherViewControllerStrId", creator: { coder in
                return WeatherViewController(coder: coder, viewModel: weatherVM)
            })
            navigationController?.pushViewController(weatherVC, animated: true)

        } else {
            guard let weatherVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewControllerStrId") as? WeatherViewController else {
                fatalError("Cannot instantiate WeatherViewController ")
            }
            weatherVC.viewModel = weatherVM
            navigationController?.pushViewController(weatherVC, animated: true)
        }


    }
}

extension TownsListViewController: AddTownViewControllerDelegate {
    func didFinish() {
        popAndUpdate()
    }

    func didCancel() {
        popAndUpdate()
    }

    private func popAndUpdate() {
        navigationController?.popViewController(animated: true)
        tableView.reloadData()
    }
}

