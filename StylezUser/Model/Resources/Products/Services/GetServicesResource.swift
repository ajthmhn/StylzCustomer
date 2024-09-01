//
//  GetServices.swift
//  StylezUser
//
//  Created by mac on 17/03/2024.
//

import Foundation
import StylesWebKit

struct GetMyServiceResource{
    
    func getServices(request:GetServicesRequest,completionHandler:@escaping ( _ services:[Services]?)->()) {
        
        let requestBody = request.getRequestBody()
        let id = requestBody.0
        let gender = requestBody.1
        
        StylzAPIFacade.shared.getServices(id:id, gender:gender,employeeId: request.employeeID,categoryID: request.categoryId) { (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                   
                    var _services  = [Services]()
                    
                    if let data = aRes?.json?["services"].array{
                        for m in data{
                            
                            let services = Services(json: m)
                            _services.append(services)
                        
                        }
                    }
                    //print("categories count \(_services.count)")
                    completionHandler( _services)
                }
                else{
                completionHandler(nil)
                }
            }else{
                completionHandler(nil)
            }
        }
    }
}
