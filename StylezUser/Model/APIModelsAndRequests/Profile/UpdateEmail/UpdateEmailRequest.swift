//
//  UpdateEmailRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 2/29/24.
//

import Foundation

struct UpdateEmailRequest: Encodable {
   
 //   let userID:Int
    let email: String

    func getRequestBody() -> [String:Any]{
        var  details = [String:Any]()
        
        details["email"] = email
   //     details["user_id"] = userID
        
        return details
    }
    
}
