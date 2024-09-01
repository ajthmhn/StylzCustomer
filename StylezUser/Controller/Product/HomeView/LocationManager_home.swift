//
//  homeLocationManager.swift
//  StylezUser
//
//  Created by MACBOOK on 2/28/24.
//

import Foundation
import CoreLocation
import UIKit

extension HomeViewController{
    
    func locationAuthorizationStatus() -> CLAuthorizationStatus {
        let locationManager = CLLocationManager()
        var locationAuthorizationStatus : CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            locationAuthorizationStatus =  locationManager.authorizationStatus
        } else {
            // Fallback on earlier versions
            locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        }
        return locationAuthorizationStatus
    }

    func requateLocation(){
        DispatchQueue.global(qos: .default).async {
            
            if CLLocationManager.locationServicesEnabled() {
                //switch CLLocationManager.authorizationStatus() {
                switch self.locationAuthorizationStatus(){
                
                
                case  .denied, .restricted:
                    DispatchQueue.main.async {
                        self.viewLocation.isHidden = false
                        self.moveToEnableLocationView()
                    }
                case .authorizedAlways, .authorizedWhenInUse:
                    self.locationManager.delegate = self
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self.locationManager.startUpdatingLocation()
                    DispatchQueue.main.async {
                        self.viewLocation.isHidden = true
                        self.hideEnableLocationViewIfVisible()
                    }
                case .notDetermined:
                    DispatchQueue.main.async {
                        self.viewLocation.isHidden = false
                        self.moveToEnableLocationView()
                    }
                @unknown default:
                    break
                }
            } else {
                DispatchQueue.main.async {
                    self.viewLocation.isHidden = false
                    self.moveToEnableLocationView()
                }
            }
        }
    }
}


//MARK: - delegate  
extension HomeViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        DispatchQueue.main.async {
            if addressSelected == false{
                let location:CLLocation = locations[0] as CLLocation
                
                location.fetchCityAndCountry { city, country, error in
                    guard let city = city, let country = country, error == nil else { return }
                    //   //print(city + ", " + country)  // Rio de Janeiro, Brazil
                    self.lbladdress.text = "\(city), \(country)"
                    
                    latitude = location.coordinate.latitude
                    longitude = location.coordinate.longitude
                    mylatitude = location.coordinate.latitude
                    mylongitude = location.coordinate.longitude
                    myAddress = self.lbladdress.text ?? ""
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        if self.dataGot == false{
                            self.dataGot = true
                            self.getTop10()
                            self.getAllBarbers()
                        }
                    }
                    
                }
            }else{
                //print("~~ updaaating selected address")
                
                self.lbladdress.text = userAddress
                
                DispatchQueue.global(qos: .userInitiated).async {
                    if self.dataGot == false{
                        self.dataGot = true
                        self.getTop10()
                        self.getAllBarbers()
                        
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        //    //print("Error \(error)")
    }
    
}


//MARK: - reverse geeocoding fetching adddres name annd country
extension CLLocation {

    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        let locale = Locale(identifier: "en")
        
        CLGeocoder().reverseGeocodeLocation(self, preferredLocale: locale) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
    
}



//MARK: - move to enable location view
extension HomeViewController{
    
    func moveToEnableLocationView(){
        
        //print("enable location view is pressenting.. \(K.LocationView.enableLocationViewIsPresented)")
        
        if K.LocationView.enableLocationViewIsPresented == false{
           
            K.LocationView.enableLocationViewIsPresented = true
        
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EnableLocationViewController") as! EnableLocationViewController
            
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            
            K.LocationView.isLocationViewVisivble = true
            
            self.present(vc, animated: true)
        }
    }
    
    func hideEnableLocationViewIfVisible(){
        //print("dismiss")
 
        if K.LocationView.isLocationViewVisivble{
          
            K.LocationView.isLocationViewVisivble = false
            
            //print("Dismissing..")
            
            self.dismiss(animated: false)
            
        }
    }
    
}
