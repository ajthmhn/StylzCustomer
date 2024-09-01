//
//  getTop10SalonsRequest.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation

struct GetTop10SalonsRequest {
    
    let gender: Int
    let lat : Double
    let lon : Double
    
    func getRequestBody() -> [String:Any]{
        
        var details = [String:Any]()
        details["latitude"] = lat
        details["longitude"] = lon
        details["gender"] = gender
            
        return details
    }
    
    
}


