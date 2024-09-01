//
//  DeleteAddressRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation

struct DeleteAddressRequest {
   
    let id: Int
    
    func getRequestBody() -> Int{
    return id
    }
}
    
 
