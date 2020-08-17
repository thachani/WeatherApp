//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Tarek HACHANI on 17/08/2020.
//  Copyright © 2020 Tarek-HACHANI. All rights reserved.
//

import Foundation
import WeatherCore
import UIKit

class WeatherViewModel {
    var currentTown: Town
    var weather: Weather?
    
    
    init(town: Town) {
        self.currentTown = town
    }
    
    // MARK: -
    
    private let dateFormatter = DateFormatter()
    
    // MARK: - Public API
    
    var date: String? {
        guard let time = weather?.currently.time else { return nil }
        // Configure Date Formatter
        dateFormatter.dateFormat = "EEE, MMMM d"
        
        return dateFormatter.string(from: time)
    }
    
    var time: String? {
        guard let time = weather?.currently.time else { return nil }
        // Configure Date Formatter
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: time)
    }
    
    var description: String? {
        weather?.currently.weather.first?.description
    }
    
    var temperature: String? {
        guard let temperature = weather?.currently.temperature else { return nil }
        
        //MARK: - default unit Kelvin
        return String(format: "%.1f °K", temperature)
    }
    
    var windSpeed: String? {
        
        //MARK: - default unit metre/se
        guard let windSpeed = weather?.currently.windSpeed else { return nil }
        return String(format: "%.f MPS", windSpeed)
    }
    
    var image: UIImage? {
        guard let icon = weather?.currently.weather.first?.icon else {
            return nil
        }
        return UIImage(named: icon)
    }
    
    
    func fetchData(completion: @escaping () -> Void) {
        let weatherManager = WeatherDataManager()
        
        weatherManager.weatherForLocation(latitude: currentTown.latitude, longitude: currentTown.longitude) {[weak self] result in
            switch result {
            case .success(let weather):
                self?.weather = weather
                completion()
            case .failure(let error):
                print("\(error.localizedDescription)")
                completion()
            }
        }
    }
    
    //MARK: - daily
    
    func numberOfRow(forSection section: Int) -> Int {
        return weather?.daily.count ?? 0
    }
    
    func dailyWeatherDayForCell(atIndex index: IndexPath) -> String {
        guard let daily = weather?.daily, daily.count > index.row else {
            return ""
        }
        
        let day = daily[index.row]
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: day.time)
    }
    
    func dailyWeatherDateForCell(atIndex index: IndexPath) -> String {
        guard let daily = weather?.daily, daily.count > index.row else {
            return ""
        }
        
        let day = daily[index.row]
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.string(from: day.time)
    }
    
    func dailyWeatherTempForCell(atIndex index: IndexPath) -> String {
        guard let daily = weather?.daily, daily.count > index.row else {
            return ""
        }
        
        let day = daily[index.row]
        
        return String(format: "Min %.1f °K - Max %.1f °K", day.temp.min, day.temp.max)
        
    }
    
    func dailyWeatherWindSpeedForCell(atIndex index: IndexPath) -> String {
        guard let daily = weather?.daily, daily.count > index.row else {
            return ""
        }
        
        let day = daily[index.row]
        
        return String(format: "%.f MPS", day.windSpeed)
    }
    
    func dailyWeatherIconForCell(atIndex index: IndexPath) -> UIImage? {
        guard let daily = weather?.daily, daily.count > index.row else {
            return nil
        }
        
        let day = daily[index.row]
        
        guard let imageNamed = day.weatherSummary.first?.icon  else {
            return nil
        }
        
        return UIImage(named: imageNamed)
    }
    
    
}
