//
//  CategoryRequest.swift
//  StylezUser
//
//  Created by mac on 11/03/2024.
//


import Foundation

struct CategoryRequest {
    
    let gender:Int
    let keyValue: Int?
    let filterWithbranch:Bool
    
    //1 for gender //2 for branch id //3 for employee id
    
    
    func getFilerKey()->String{
        
        if filterWithbranch{
            return "branch_id"
        }
        else{
            return "employee_id"
        }
        
    }
    
    func getRequestBody() -> [String:Any]{
        
        var details = [String:Any]()
        details["gender"] = gender
        return details
    }
  
}


