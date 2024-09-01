//
//  AddAddressAutoCompletePlacesHandlee.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation
import GoogleMaps
import GooglePlaces
import UIKit

extension AddAddressViewController: GMSAutocompleteTableDataSourceDelegate {
    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        // Turn the network activity indicator off.
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        // Reload table data.
        tableView.reloadData()
    }
    
    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        // Turn the network activity indicator on.
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        // Reload table data.
        tableView.reloadData()
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        // Do something with the selected place.
        //      //print("Place name: \(place.name)")
        //      //print("Place address: \(place.formattedAddress)")
        //      //print("Place attributions: \(place.attributions)")
        
        tableView.isHidden = true
        searchBar.text = place.formattedAddress
        
        //      //print("\ncoordinate.latitude=\(place.coordinate.latitude)")
        //      //print("coordinate.longitude=\(place.coordinate.longitude)")
        //      //print("thoroughfare=\(place.thoroughfare)")
        //      //print("locality=\(place.locality)")
        //      //print("subLocality=\(place.subLocality)")
        //      //print("administrativeArea=\(place.administrativeArea)")
        //      //print("postalCode=\(place.postalCode)")
        //      //print("country=\(place.country)")
        //      //print("lines=\(place.lines)")
        
        let camera = GMSCameraPosition.camera(withLatitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude), zoom: 17.0)
      
        self.mapView?.animate(to: camera)
        
        DispatchQueue.main.async {
            self.shouldAutoFill = true
            self.addressSelecteds = true
            self.reverseGeocodeCoordinateForMovement(place.coordinate)
        }
    }
    
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        // Handle the error.
        //print("Error: \(error.localizedDescription)")
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        self.searchBar.endEditing(true)
        return true
    }
}
