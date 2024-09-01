//
//  DeleteAddressViewModel.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation

struct DeleteAddressViewModel{
    
    private let validation = DeleteAddressRequestValidation()
    private let resource = DeleteAddressReosurce()
    
    func deleteAddress(request: DeleteAddressRequest, completionHandler:@escaping (_ errorMsg: String?)->()) {
        
        let validationResult = validation.validateId(request: request)
        
        if validationResult.success{
            resource.deleteAddress(request: request) { errorMsg in
                completionHandler(errorMsg)
            }
        }
        else{
            completionHandler(validationResult.errorMessage)
        }
    }
}
