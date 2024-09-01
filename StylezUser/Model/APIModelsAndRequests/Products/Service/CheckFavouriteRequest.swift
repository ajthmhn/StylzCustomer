//
//  CheckFavouriteRequest.swift
//  StylezUser
//
//  Created by mac on 16/03/2024.
//

import Foundation


struct CheckFavouriteRequest {
   
    let id: Int
    let gender: Int
     
    func getRequestBody() -> (Int,Int){
        return (id:id, gender:gender) //tuple
    }
}
    
 
