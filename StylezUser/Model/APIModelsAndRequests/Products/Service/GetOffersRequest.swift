//
//  GetOffersRequest.swift
//  StylezUser
//
//  Created by mac on 16/03/2024.
//

import Foundation



struct GetOffersRequest{
   
    let id: Int
     
    func getRequestBody() -> Int{
        return id //tuple
    }
}
    
 
