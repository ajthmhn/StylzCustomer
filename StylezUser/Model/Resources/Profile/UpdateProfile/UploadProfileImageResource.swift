//
//  UploadProfileResource.swift
//  StylezUser
//
//  Created by abcd on 25/03/2024.
//

import Foundation
import StylesWebKit
import SwiftyJSON

struct UploadProfileImageResource{
    
    func uploadImage(request: UploadProfileImageRequest, completionHandler:@escaping (_ errorMsg: String?)->()) {
        
        StylzAPIFacade.shared.uploadImage(profDet: request.getRequestBody()) { (aRes) in
            
            //print("upload image error: \(aRes?.json?["error"].stringValue)")
            
            //print(aRes?.json)
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    completionHandler(nil)
                    
                } else{
                    let err = getErr(json: aRes?.json)
                    completionHandler(err)
                }
            }
            else{
                let err = getErr(json: aRes?.json)
                completionHandler(err)
            }
        }
    }
    
    func getMsgString(msgErr:String, err:String) -> String{
        if msgErr == ""{
            return err
        }
        else{
            return "\(msgErr), \(err)"
        }
    }
    
    func getErr(json:JSON?) -> String?{
        
        if let err = json?["message"].dictionary{
           
            var errMsg = ""
            if let imgErrs = err["image"]?.array{
             
                for m in imgErrs{
                    errMsg = getMsgString(msgErr: errMsg, err: m.stringValue)
                }
                
                if errMsg == ""{
                    errMsg = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "")
                }
                
                return errMsg
                
            }else{
                return     LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "")
            }
        }
        else{
            if let err = json?["message"].stringValue, err != ""{
                return err
            }
            else{
                return LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "")
            }
        }
    }
}


//
//{
//    "status": 404,
//    "message": {
//        "image": [
//            "No file was submitted."
//        ]
//    }
//}
//                        {
//                            "detail": "Authentication credentials were not provided."
//                        }
