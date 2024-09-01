//
//  DeleteAddressRequestValidation.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation


struct DeleteAddressRequestValidation{
    
    func validateId(request: DeleteAddressRequest) -> ValidationResult {
        if(request.id != 0 && request.id != -1){
          return  ValidationResult(success: true, errorMessage: nil)
        }
      
        return ValidationResult(success: false, errorMessage: K.Error.someThingWentWrong)
    }
}
