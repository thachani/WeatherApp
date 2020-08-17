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
        let test = Town(name: "test", latitude: 44, longitude: 2)

        UserDefaults.standard.set(value: [test], forKey: UserDefaultsKeysConst.TownsKey)
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

    @IBAction func addTownTapped(_ sender: Any) {}
}

extension TownsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.towns.count
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

