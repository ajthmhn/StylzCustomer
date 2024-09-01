//
//  File.swift
//  StylezUser
//
//  Created by mac on 14/03/2024.
//

import Foundation

struct GetShopsRequest {
    
    let gender: Int
    let lat : Double?
    let lon : Double?
    let categoryId : Int?
    let customerID : Int?

    
    func getRequestBody() -> [String:Any]{
        
        var details = [String:Any]()
        
        details["gender"] = gender
       
        details["category_id"] = categoryId
        details["latitude"] = latitude
        details["longitude"] = longitude
    
        details["customer_id"] = customerID
    
        return details
    }
}


