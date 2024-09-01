//
//  NotifcationRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 3/6/24.
//

import Foundation

struct NotificationRequest {
   
    let page: Int
    let gender: Int
     
    func getRequestBody() -> (Int,Int){
        return (page:page, gender:gender) //tuple
    }
}
    
 
