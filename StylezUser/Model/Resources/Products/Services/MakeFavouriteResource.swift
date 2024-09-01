//
//  MakeFavouriteReesource.swift
//  StylezUser
//
//  Created by mac on 17/03/2024.
//

import Foundation
import StylesWebKit

struct MakeFavouriteResource{
    
    func getEmployees(request:MakeFavRequest,completionHandler:@escaping (_  success: Bool)->()) {
        
        let requestBody =  request.getRequestBody()
        
        let id = requestBody.0
        let gender = requestBody.1
        let status = requestBody.2
        
        StylzAPIFacade.shared.makeFavourite(id: id, status:status , gender:gender ) { (aRes) in
            
            if aRes?.statusCode == 200{
            
                if aRes?.json?["status"].intValue == 200{
                    completionHandler(true)
                }else{
                    completionHandler(false)
                }
                
            }else{
                completionHandler(false)
            }
        }
    }
}
