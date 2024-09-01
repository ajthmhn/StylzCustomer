//
//  AddRatingRequest.swift
//  StylezUser
//
//  Created by abcd on 14/04/2024.
//

import Foundation


struct AddRatingRequest {
   
    let rating:Int
    let review:String
    let brancID:Int
    let customerID:Int
    let appointmentID:Int
    
    func getRequestBody() -> [String:Any]{
        
        var details = [String:Any]()
        
        details["rating"] = rating
        details["customer"] = customerID
        details["review"] = review
       
        details["shop"] = brancID
        details["appointment"] = appointmentID
       
        
        return details
    }
    
}
