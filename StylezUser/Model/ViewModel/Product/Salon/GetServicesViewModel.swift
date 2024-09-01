//
//  GetServicesViewModeel.swift
//  StylezUser
//
//  Created by mac on 15/03/2024.
//

import Foundation
import StylesWebKit


// this validation is not actually required.

struct GetServicesViewModel{
    
   private let validation = ServiceValidation()
   private let resource = GetMyServiceResource_top10Salons()
 
    func myServices_top10Salons(request: ServicesRequest, completionHandler:@escaping (_ salons: [Salons]?, _ err:String?)->()) {
        
        let validationResult = validation.ValidateService(request: request)
        
        if validationResult.success{
           
            resource.myServices_top10Salons(request: request) { salons,err  in
               completionHandler(salons, err)
           }
        }
        else{
            completionHandler(nil, validationResult.errorMessage)
        }
    }
}

