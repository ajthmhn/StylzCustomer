//
//  RegistrationViewModel.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation
struct RegistrationViewModel{

    func registerUser(request: RegisterRequest, completionHandler:@escaping (_ result: RegistrationResponse?, _ errorMsg: String?)->()) {
        
        let validation = RegisterValidations()
       
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let resource = RegistrationResource()
            resource.registerUser(request: request) { result, err in
               completionHandler(result,err)
            }
        }
        else{
            completionHandler(nil, validationResult.errorMessage)
        }
    
    }
}
