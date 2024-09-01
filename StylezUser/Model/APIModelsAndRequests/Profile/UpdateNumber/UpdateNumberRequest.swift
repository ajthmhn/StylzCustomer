//
//  UpdateNumberRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 2/29/24.
//

import Foundation

struct UpdateNumberRequest: Encodable {
   
    //let userID:Int
    let number: String

    func getRequestBody() -> [String:Any]{
        var  details = [String:Any]()
        
        details["phone"] = number
      //  details["user_id"] = userID
        
        return details
    }
    
}
