//
//  updateNumberViewModel.swift
//  StylezUser
//
//  Created by MACBOOK on 2/29/24.
//

import Foundation

struct updateNumberViewModel{
    
   private let validation = UpdateNumberValidation()
   private let resource = UpdateNumberResource()
 
    func updatePhone(request: UpdateNumberRequest, completionHandler:@escaping (_ otp: String?, _ userID:Int?, _ errorMsg: String?)->()) {
        
        let validationResult = validation.validateNumber(request: request)
        
        if validationResult.success{
           
            resource.updatePhone(request: request){ otp, userID, errorMsg in
                
            completionHandler(otp, userID, errorMsg)
           
            }
        }
        else{
            completionHandler(nil,nil, validationResult.errorMessage)
            
        }
    }
}

