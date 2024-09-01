//
//  MarkFavRequest.swift
//  StylezUser
//
//  Created by mac on 17/03/2024.
//

import Foundation

struct MakeFavRequest{
    let salon_Id: Int
    let gender: Int
    let  favStatus:Int
     
    func getRequestBody() -> (Int,Int,Int){
        return (id:salon_Id, gender:gender, favStatus: favStatus) //tuple
    }
}
    
 


