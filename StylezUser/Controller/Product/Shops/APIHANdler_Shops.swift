//
//  APIHANdler_Shops.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import UIKit
import StylesWebKit

extension ShopsViewController{
    
    func getShops(){
        self.salons.removeAll()
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let gender = getGenderCode()
        let id = getCustomerID()
        
        let request = GetShopsRequest(gender: gender , lat: latitude, lon: longitude, categoryId: categoryId,customerID: id)
       
        //print("cat id \(categoryId), shops request \(request)")
        let resource = GetShopsResource()
        
        resource.getBranches(request: request) { salons in
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if let salons{
                    self.salons = salons
                }
                
                self.updateTableSalonsView()
            }
        }
    }
    
}
