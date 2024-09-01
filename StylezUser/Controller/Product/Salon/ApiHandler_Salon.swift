//
//  ApiHandler_Salon.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import UIKit
import StylesWebKit

//MARK: - get my salons
extension SalonsViewController{

    func getMySalons(){
        self.salons.removeAll()
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let gender = getGenderCode()
    
        let request = GetMySalonsRequest(gender: gender)
        
        let reosurce = GetMySalonResource()
        reosurce.mySalons(request: request) { salons in
          
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if let salons{
                    self.salons = salons
                }
                self.updateSalonView()
            }
        }
    }
}

//MARK: - get top 10 salons
extension SalonsViewController{
    
    func getTop10Salons(){
        self.salons.removeAll()
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let gender = getGenderCode()
        let request = ServicesRequest(gender: gender, lat: latitude, lon: longitude, serviceId: serviceId)
        
        let viewModel = GetServicesViewModel()
        viewModel.myServices_top10Salons(request: request){ salons, err  in
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if err != nil{
                   showAlert(title:"", subTitle: err!, sender: self)
                }
                else{
                    if let salons{
                        self.salons = salons
                    }
                }
                self.updateSalonView()
            }
        }
    }
}


//MARK: - get ALl barbers
extension SalonsViewController{
  
    func getAllBarbers(){
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
                
                self.updateSalonView()
            }
        }
    }
    
}
