//
//  AddAddressLocationManager.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation
import CoreLocation
import GoogleMaps

//MARK: - handling location manager
extension AddAddressViewController{
    
    func configLocationManager(){
        if selectedAddres != nil{
           
            //print("~ 3 config Location manager selected address is not equal to nil")
            
            shouldAutoFill = false
           
            if self.selectedAddres?.latitude == nil || self.selectedAddres?.latitude == ""{
                
                //print("~ 4 config Location manager lat == nil")
             
                DispatchQueue.global(qos: .default).async {
                    [weak self] in
                    
                    self?.locationManager.requestWhenInUseAuthorization()
                    
                    if CLLocationManager.locationServicesEnabled() {
                        self?.locationManager.delegate = self
                        self?.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                        self?.locationManager.startUpdatingLocation()
                    }
                }
                
                DispatchQueue.main.async {
                    showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "pin_location", comment: ""), sender: self)
                }
            }else{
               
                //print("~ 5 config Location manager lat != nil - else block")
             
                self.countryLatitude = Double(self.selectedAddres?.latitude ?? "0.0")
                self.countryLongitude = Double(self.selectedAddres?.longitude ?? "0.0")
                
                let camera = GMSCameraPosition.camera(withLatitude: (self.countryLatitude ?? 0.0), longitude: (self.countryLongitude ?? 0.0), zoom: 17.0)
              
                self.mapView?.animate(to: camera)
            }
            
            txtNickName.text = self.selectedAddres?.nick_name
            
            if self.selectedAddres?.is_default == 1{
                self.isDefault.isOn = true
            }else{
                self.isDefault.isOn = false
            }
            
            btnAdd.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_address", comment: ""), for: .normal)
            
        }else{
           
            //print("~ 6 config Location manager selected address is equal to nil")
          
            DispatchQueue.global(qos: .default).async {
                [weak self] in
                
                self?.locationManager.requestWhenInUseAuthorization()
                
                if CLLocationManager.locationServicesEnabled() {
                    self?.locationManager.delegate = self
                    self?.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self?.locationManager.startUpdatingLocation()
                }
            }
            
            btnAdd.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_address", comment: ""), for: .normal)
        }
        
    }
    
}
//MARK: - location manager delegate
extension AddAddressViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isFristTime == true {
            if selectedAddres != nil{
                //print("~ 1 Location manager selected address is not equal to nil")
                
                if self.selectedAddres?.latitude == nil || self.selectedAddres?.latitude == ""{
                    let location:CLLocation = locations[0] as CLLocation
                    let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: 17.0)
                    self.mapView?.animate(to: camera)
                    DispatchQueue.main.async {
                        self.reverseGeocodeCoordinateForMovement(location.coordinate)
                    }
                }else{
                    //print("~ 7 location manager selected address is equal to nil")
                  
                    let camera = GMSCameraPosition.camera(withLatitude: (self.countryLatitude ?? 0.0), longitude: self.countryLongitude ?? 0.0, zoom: 17.0)
                    self.mapView?.animate(to: camera)
                    DispatchQueue.main.async {
                        self.reverseGeocodeCoordinateForMovement(CLLocationCoordinate2D(latitude: self.countryLatitude ?? 0.0, longitude: self.countryLongitude ?? 0.0))}
                }
            }else{
                let location:CLLocation = locations[0] as CLLocation
                let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: 17.0)
                self.mapView?.animate(to: camera)
                DispatchQueue.main.async {
                    self.reverseGeocodeCoordinateForMovement(location.coordinate)
                }
            }
            self.locationManager.stopUpdatingLocation()
            self.isFristTime = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        //print("Error \(error)")
    }
}


//MARK: - mapview delegate
extension AddAddressViewController : GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        //if isFristTime == true{
        DispatchQueue.main.async {
            if self.isFristTime == false{
                self.addressSelecteds = true
            }
            self.reverseGeocodeCoordinateForMovement(position.target)
        }
    }
    
     func reverseGeocodeCoordinateForMovement(_ coordinate: CLLocationCoordinate2D) {
        
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        if valueNOtTaken == false{
            valueNOtTaken = true
        }else{
            //print("latituddee and long  \(countryLatitude), \(countryLongitude)")
            countryLongitude = coordinate.longitude
            countryLatitude = coordinate.latitude
        }
        
        
      //3 
         geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            self.searchBar.text = lines.joined(separator: "\n")
            self.crntaddress = lines.joined(separator: "\n")
           
             
             //sun,14 april - its updating adddress before clicking on the update aaddress button
             
             if self.homeView != nil{
                 //print(" ~ updating user address")
                 //      userAddress = "456 \(address.country ?? ""), \(address.locality ?? "")"
                 self.tempAddress = "456 \(address.country ?? ""), \(address.locality ?? "")"
             }
             
//
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
            
            //                    //print("\ncoordinate.latitude=\(address.coordinate.latitude)")
            //                    //print("coordinate.longitude=\(address.coordinate.longitude)")
            //                    //print("thoroughfare=\(address.thoroughfare)")
            //                    //print("locality=\(address.locality)")
            //                    //print("subLocality=\(address.subLocality)")
            //                    //print("administrativeArea=\(address.administrativeArea)")
            //                    //print("postalCode=\(address.postalCode)")
            //                    //print("country=\(address.country)")
            //                    //print("lines=\(address.lines)")
        }
    }
}
