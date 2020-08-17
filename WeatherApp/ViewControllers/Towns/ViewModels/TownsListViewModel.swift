//
//  TownsListViewModelView.swift
//  WeatherApp
//
//  Created by Tarek HACHANI on 17/08/2020.
//  Copyright © 2020 Tarek-HACHANI. All rights reserved.
//

import Foundation

struct TownsListViewModel {

    var towns: [Town] {
        let savedTowns: [Town]? = UserDefaults.standard.codable(forKey: UserDefaultsKeysConst.TownsKey)
        
        guard let towns = savedTowns else {
            return []
        }
        return towns
    }

    func titleForCell(atIndex index: IndexPath) -> String {
        guard towns.count > index.row else {
            return ""
        }

        let town = towns[index.row]
        return town.name
    }
}
