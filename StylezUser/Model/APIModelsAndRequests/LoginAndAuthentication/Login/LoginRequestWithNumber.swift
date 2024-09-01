//
//  LoginRequestWithNumber.swift
//  StylezUser
//
//  Created by MACBOOK on 2/29/24.
//

import Foundation


struct LoginRequestWithNumber: Encodable {
   
    let number: String

    func getLoginRequestBody() -> [String:Any]{
       
        var  loginObj = [String:Any]()
        
        loginObj["phone"] = number
        
        return loginObj
    }
    
}
