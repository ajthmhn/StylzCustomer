//
//  GetServicesRequest.swift
//  StylezUser
//
//  Created by mac on 15/03/2024.
//


import Foundation

// used iin salon controller
struct ServicesRequest {
    
    let gender: Int
    let lat : Double
    let lon : Double
    let serviceId : Int
    
    func getRequestBody() -> [String:Any]{
       
        var details = [String:Any]()
        
        details["service_id"] = serviceId
        details["gender"] = gender
        details["latitude"] = latitude
        details["longitude"] = longitude
 
        return details
    }
    
}



