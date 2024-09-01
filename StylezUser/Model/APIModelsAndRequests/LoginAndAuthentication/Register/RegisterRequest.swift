//
//  RegisterRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 2/21/24.
//

import Foundation
import StylesWebKit

struct RegisterRequest {
    
    let phone,email,password,firstName,occupation:String
    let countryID: Int
    let age:Int
    let ispolicyAccepted:Bool
    let gender:Int
    let fcm_id:String
    // var country = [Countrys]()
     
    
    func getRequestBody() -> [String:Any]{
        
        var  details = [String:Any]()
        
        details["first_name"] = firstName
        details["email"] = email
        details["password"] = password
        details["phone"] = phone
        details["fcm_id"] = fcm_id
        details["gender"] = gender
        details["age"] = age
        
        //  details["occupation"] = occupation
      
        if countryID != -1 && countryID != 0 {
            details["country_id"] = countryID
        }
        
        return details
    }
    
}

