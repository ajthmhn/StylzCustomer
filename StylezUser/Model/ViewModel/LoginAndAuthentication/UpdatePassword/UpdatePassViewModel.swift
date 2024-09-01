//
//  UpdatePassViewModel.swift
//  StylezUser
//
//  Created by MACBOOK on 2/26/24.
//

import Foundation

struct UpdatePassViewModel{
    
    
    func updatePassword(request: UpdatePasswordRequest, completionHandler:@escaping ( _ errorMsg: String?)->())
    {
        let validation = UpdatePasswordValidation()
        
        let validationResult = validation.validate(request: request)
       
        if validationResult.success{
            
            let resource = UpdatePasswordResource()
            
            resource.updatePassword(request: request) { errorMsg in
            
            completionHandler(errorMsg)
        
            }
        }
        else{
            completionHandler(validationResult.errorMessage)
        }
    }
}
