//
//  DeleteAddressReosurce.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation
import StylesWebKit
import SwiftyJSON


struct DeleteAddressReosurce{
    
    func deleteAddress(request:DeleteAddressRequest,completionHandler:@escaping (_ errorMsg: String?)->()) {
        
        StylzAPIFacade.shared.deleteAddress(id: request.getRequestBody()){ aRes in
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    completionHandler(nil)
                }
                else{
                    
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
extension DeleteAddressReosurce{
    func getErrMsg(json:JSON?)->String{
        if let err = json?["message"].stringValue, err != ""  {
            return err
        }
        else{
            return     LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "")
        }
    }
}

