//
//  HomeAPIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/28/24.
//

import StylesWebKit
import Foundation
import UIKit
    

//MARK: - getAddress
extension HomeViewController{
    
    func getAddress(){
        
        self.addressList.removeAll()
        
        let resource = GetAddressDataResource()
        resource.addressList{ addressList in
        
            if let addressList{
                self.addressList = addressList
            }
        }
    }
}


//MARK: - get ALl barbers
extension HomeViewController{
  
    func getAllBarbers(){
        self.allBarbers.removeAll()
          
        let gender = getGenderCode()
        let id = getCustomerID()
       
        let request = GetShopsRequest(gender: gender , lat: latitude, lon: longitude, categoryId: nil, customerID: id)
        
        let resource = GetShopsResource()
        
        resource.getBranches(request: request) { salons in
       
            DispatchQueue.main.async {
               
                if let salons{
                    self.allBarbers = salons
                }
                
                self.updateBarbersView()
            }
        }
    }
    
    
    // MARK: not using
    func getAllBarbers2(){
        
      self.allBarbers.removeAll()
        
        let gender = getGenderCode()
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
       
        let request = GetAllBArbersRequest(gender: gender, lat: latitude, lon: longitude, customerID: id)
        
        let resource = GetAllBarbersResource()
        resource.allBarbers(request: request){ salons in
            
            DispatchQueue.main.async {
              
                if let salons{
                    self.allBarbers = salons
                }
                self.updateBarbersView()
            }
        }
    }
    
    
    //MARK: update barber view
    func updateBarbersView(){
        if self.allBarbers.count == 0{
            self.viewNoDataBarber.isHidden = false
            self.barberHeight.constant = 280
        }
        else{
            self.tblBarber.reloadData()
            self.viewNoDataBarber.isHidden = true
            self.barberHeight.constant = CGFloat((270 * self.allBarbers.count) + 120)
        }
    }
}

//MARK: - get top 10
extension HomeViewController{
    
    func getTop10(){
        self.salons.removeAll()
       
        let gender = getGenderCode()
        let id = getCustomerID()
       
        let request = GetShopsRequest(gender: gender , lat: latitude, lon: longitude, categoryId: nil, customerID: id)
       
        let resource = GetShopsResource()
        
        resource.getBranches(request: request) { salons in
       
            DispatchQueue.main.async {
                if let salons{
                    self.salons = salons
                }
                self.updateTop10SalonsView()
            }
        }
    }
    
    // MARK: not using
    func getTop102()
    {
        self.salons.removeAll()
        
        let gender = getGenderCode()
        
        let request = GetTop10SalonsRequest(gender: gender, lat: latitude, lon: longitude)
        
        let resource = GetTop10SalonsResource()
        
        resource.top10Salons(request: request) { salons in
            DispatchQueue.main.async {
                
                if let salons{
                    self.salons = salons
                }
                self.updateTop10SalonsView()
            }
        }
    }
    
    
    //MARK: update top10 salon view
    func updateTop10SalonsView(){
            if self.salons.count == 0{
                self.viewNoDataSaloon.isHidden = false
                self.saonHeight.constant = 280
            }else{
                self.viewNoDataSaloon.isHidden = true
                self.saonHeight.constant = CGFloat((100 * self.salons.count) + 80)
                self.tblTop.reloadData()
            }
    }
}

