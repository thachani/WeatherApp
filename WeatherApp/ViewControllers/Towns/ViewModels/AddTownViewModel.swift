//
//  AddTownViewModel.swift
//  WeatherApp
//
//  Created by Tarek HACHANI on 17/08/2020.
//  Copyright © 2020 Tarek-HACHANI. All rights reserved.
//

import Foundation

struct AddTownViewModel {

    func add(name: String, latitude: Double, longitude: Double) {
        let town = Town(name: name, latitude: latitude, longitude: longitude)
        var savedTowns = savedtowns()
        savedTowns.append(town)
        setTowns(towns: savedTowns)
    }

    // MARK: - privates

    private  func savedtowns() -> [Town] {
        let towns: [Town]? = UserDefaults.standard.codable(forKey: UserDefaultsKeysConst.TownsKey)

        guard let savedTowns = towns else {
            return []
        }
        return savedTowns
    }

    private  func setTowns(towns: [Town]) {
        UserDefaults.standard.set(value: towns, forKey: UserDefaultsKeysConst.TownsKey)
        UserDefaults.standard.synchronize()
    }
    
}
