//
//  AddTownViewController.swift
//  WeatherApp
//
//  Created by Tarek HACHANI on 17/08/2020.
//  Copyright © 2020 Tarek-HACHANI. All rights reserved.
//

import UIKit
import CoreLocation

protocol AddTownViewControllerDelegate: AnyObject {
    func didFinish()
    func didCancel()
}

class AddTownViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: -
    let viewModel: AddTownViewModel = AddTownViewModel()
    
    
    // MARK: -
    
    private lazy var geocoder = CLGeocoder()
    
    // MARK: -
    
    weak var delegate: AddTownViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Add Town"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Show Keyboard
        searchBar.becomeFirstResponder()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Helper Methods
    
    private func geocode(addressString: String?) {
        guard let addressString = addressString else { return }
        
        // Geocode City
        geocoder.geocodeAddressString(addressString) { [weak self] (placemarks, error) in
            DispatchQueue.main.async {
                // Process Forward Geocoding Response
                self?.processResponse(withPlacemarks: placemarks, error: error)
            }
        }
    }
    
    // MARK: -
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            
        } else if let matches = placemarks {
            for match in matches {
                guard let name = match.name else { return }
                guard let location = match.location else { return }
                viewModel.add(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
            delegate?.didFinish()
        }
    }
}

extension AddTownViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()
        
        // Forward Geocode Address String
        geocode(addressString: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()
        
        delegate?.didCancel()
    }
    
}
