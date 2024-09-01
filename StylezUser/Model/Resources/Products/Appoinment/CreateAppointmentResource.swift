//
//  CreateAppointmentRequest.swift
//  StylezUser
//
//  Created by abcd on 01/04/2024.
//


import Foundation
import StylesWebKit
import SwiftyJSON

struct CreateAppointmentResource{
    
    func lockTimeSlote(request:CreateAppointmentRequest,completionHandler:@escaping (_ appointmentID: String?,_ referenceID: String?,_ errorMsg:String?)->()) {
        
        StylzAPIFacade.shared.lockTimeSlote(profDet: request.getRequestBody()) { (aRes) in
            
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
               
                    if let data = aRes?.json?["data"].dictionary{
                    
                        
                        let referanceId = data["reference_id"]?.stringValue ?? ""
                       
                        let appointmentID = data["appointment_date"]?.stringValue ?? ""
                   
                        completionHandler(appointmentID,referanceId,nil)
                    }
                    else{
                     completionHandler(nil,nil,LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                    }
                }
                else{
                    completionHandler(nil,nil,getErrMsg(json: aRes?.json))
                }
            }
            else{
                completionHandler(nil,nil, getErrMsg(json: aRes?.json))
            }
        }
    }
    
}

//
//
////MARK: - handling error
//extension CreateAppointmentResource{
//    
//    func getErrMsg(json:JSON?)->String{
//        if let err = json?["message"].stringValue, err != ""  {
//            return err
//        }
//        else{
//            return     LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "")
//        }
//    }
//}
//
