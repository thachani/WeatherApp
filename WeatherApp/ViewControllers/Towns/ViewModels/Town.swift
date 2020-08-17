//
//  Town.swift
//  WeatherApp
//
//  Created by Tarek HACHANI on 17/08/2020.
//  Copyright © 2020 Tarek-HACHANI. All rights reserved.
//

import Foundation
import CoreLocation

struct Town: Codable{
    
    // MARK: - Properties
    
    let name: String
    let latitude: Double
    let longitude: Double

    // MARK: -

//    var location: CLLocation {
//        return CLLocation(latitude: latitude, longitude: longitude)
//    }
}

//extension Town: Equatable {
//
//    static func ==(lhs: Town, rhs: Town) -> Bool {
//        guard lhs.name == rhs.name else { return false }
//        guard lhs.latitude == rhs.latitude else { return false }
//        guard lhs.longitude == rhs.longitude else { return false }
//        return true
//    }
//
//}



