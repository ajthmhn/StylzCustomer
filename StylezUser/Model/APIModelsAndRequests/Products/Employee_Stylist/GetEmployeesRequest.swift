//
//  GetEmployeesRequest.swift
//  StylezUser
//
//  Created by mac on 17/03/2024.
//

import Foundation

struct GetEmployeesRequest {
       
        let lat:String
        let lon:String
        let gender:Int
      
        let branchId:Int?
        let serviceID:Int?
        let employeeID:Int?
    
        func getRequestBody() -> [String:Any]{
            
            var details = [String:Any]()
            
            details["latitude"] = lat
            details["longitude"] = lon
            details["gender"] = gender
            
            return details
        }
    
    //branch = 1, empployee = 2, services = 3
    func getFilterKey(filterCode:Int)->String{
     
        switch filterCode{
        case 1:
            return "branch_id"
        case 2:
            return "employee_id"
        case 3:
            return "service_id"
        default:
            return ""
        }
    }
        
    
        
}
