//
//  AddAddressViewModel.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//


import Foundation

struct AddAddressViewModel{
    
    private let validation = AddAddressRequestValidation()
    private let resource = AddAddressResource()
    
    func createAddress(request: AddAddressRequest, completionHandler:@escaping (_ errorMsg: String?)->()) {
        
        let validationResult = validation.validateAddress(request: request)
        
        if validationResult.success{
            resource.createAddress(request: request){ errorMsg in
                completionHandler(errorMsg)
            }
        }
        else{
            completionHandler(validationResult.errorMessage)
        }
    }
}
