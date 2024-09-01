//
//  RescheduleAppointmentReesource.swift
//  StylezUser
//
//  Created by mac on 18/03/2024.
//

import Foundation
import StylesWebKit
import SwiftyJSON

struct RescheduleAppointmentReesource{
    
    func resceduleAppointment(request:RescheduleAppointmentRequest,completionHandler:@escaping (_ errMsg: String?)->()) {
        
        
        StylzAPIFacade.shared.resceduleAppointment(id: request.appointmentID, date: request.date, startTime: request.startTime, endTime: request.endTime, salonId: request.salonId)
        {
            (aRes) in
            
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
extension RescheduleAppointmentReesource{
    func getErrMsg(json:JSON?)->String{
        if let err = json?["message"].stringValue, err != ""  {
            return err
        }
        else{
            return     LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "")
        }
    }
}

