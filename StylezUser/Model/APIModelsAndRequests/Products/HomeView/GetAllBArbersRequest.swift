//
//  GetAllBArbersRequest.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//


import Foundation

struct GetAllBArbersRequest {
    
    let gender: Int
    let lat : Double
    let lon : Double
    let customerID : Int
    
    func getRequestBody() -> [String:Any]{
        
        var details = [String:Any]()
        
        details["latitude"] = lat
        details["longitude"] = lon
        details["gender"] = gender
     
        if getUserDetails() != nil{
            details["customer_id"] = customerID
        }
        
        return details
    }
    
    
}


