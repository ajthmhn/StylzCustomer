//
//  AddAddressResource.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation
import StylesWebKit
import SwiftyJSON

struct AddAddressResource{
    
    func createAddress(request: AddAddressRequest, completionHandler:@escaping (_ errorMsg: String?)->()) {
        
        StylzAPIFacade.shared.createAddress(profDet: request.getRequestBody()) { (aRes) in
            
            if aRes?.statusCode == 201{
                if aRes?.json?["status"].intValue == 201{
                    
                    completionHandler(nil)
                    
                }else{
                    
                    completionHandler(getErrMsg(json: aRes?.json))
                }
            }
            else{
                completionHandler(getErrMsg(json: aRes?.json))
            }
        }
    }
}


//MARK: - handling error
extension AddAddressResource{
    func getErrMsg(json:JSON?)->String{
        if let err = json?["message"].stringValue, err != ""  {
            return err
        }
        else{
            return     LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "")
        }
    }
}

