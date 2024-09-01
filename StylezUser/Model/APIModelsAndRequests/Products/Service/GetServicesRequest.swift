//
//  GetServicesRequest.swift
//  StylezUser
//
//  Created by mac on 17/03/2024.
//

import Foundation

struct GetServicesRequest {
   
    let salon_Id: Int //brach
    let categoryId:Int?
    let employeeID:Int?
    let gender: Int
     
    func getRequestBody() -> (Int,Int){
        return (id:salon_Id, gender:gender) //tuple
    }
    
}
    
 
