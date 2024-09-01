//
//  UpdateProfileRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 3/3/24.
//

import Foundation
import UIKit

struct UpdateProfileRequest {
   
    let name: String
    let countryID: String
    let age: String
    let occupation: String
   
    func getRequestBody() -> [String:Any]{
      
        var profDic = [String:Any]()
        
        profDic["first_name"] = name
        profDic["age"] = age
        profDic["occupation"] = occupation
        
    return profDic
}
}
