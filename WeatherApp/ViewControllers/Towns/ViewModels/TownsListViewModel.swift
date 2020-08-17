//
//  TownsListViewModelView.swift
//  WeatherApp
//
//  Created by Tarek HACHANI on 17/08/2020.
//  Copyright © 2020 Tarek-HACHANI. All rights reserved.
//

import Foundation
import UIKit

struct TownsListViewModel {

    var towns: [Town] {
        let savedTowns: [Town]? = UserDefaults.standard.codable(forKey: UserDefaultsKeysConst.TownsKey)
        
        guard let towns = savedTowns else {
            return []
        }
        return towns
    }

    func numberOfRow(forSection section: Int) -> Int {
        return towns.count
    }

    func titleForCell(atIndex index: IndexPath) -> String {
        guard towns.count > index.row else {
            return ""
        }

        let town = towns[index.row]
        return town.name
    }

    func getWeatherViewModel(forIndexPath index: IndexPath) -> WeatherViewModel {
        let town = towns[index.row]
        return WeatherViewModel(town: town)
    }
}
