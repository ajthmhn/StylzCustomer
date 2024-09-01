//
//  GetEmployeesResources.swift
//  StylezUser
//
//  Created by mac on 17/03/2024.
//

import Foundation
import StylesWebKit

struct GetEmployeesResources{
    
    func getEmployees(request:GetEmployeesRequest,completionHandler:@escaping (_ employees: [Employee]?)->()) {
        
        //print(request)
        StylzAPIFacade.shared.getEmployees(lat: request.lat, lon: request.lon, gender: request.gender,branchId: request.branchId,employeeId: request.employeeID
                                           ,servicesID: request.serviceID){ (aRes) in
                
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    var  employeeList = [Employee]()
                    if let data = aRes?.json?["data"].array{
                        for m in data{
                            let booking = Employee(json: m)
                            employeeList.append(booking)
                        }
                    }
                    completionHandler(employeeList)
                }else{
                    completionHandler(nil)
                }
            }else{
                completionHandler(nil)
            }
        }
    }
}
