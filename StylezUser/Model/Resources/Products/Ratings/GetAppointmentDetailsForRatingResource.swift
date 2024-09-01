//
//  GetAppointmentDetailsForRatingResource.swift
//  StylezUser
//
//  Created by abcd on 17/04/2024.
//

import Foundation

import StylesWebKit
import SwiftyJSON


struct GetAppointmentDetailsForRatingResource{
    
    func getAppointmentRatingDetails(completionHandler:@escaping (_ appointment:Appointments?, _ errorMsg:String?)->()) {
        
        StylzAPIFacade.shared.getAppointmentRatingDetails{ (aRes) in
            
            //print("last appointment: \(aRes?.json)")
            
            if aRes?.statusCode == 200{
                
                if aRes?.json?["status"].intValue == 200{
                    
                    var appointment:Appointments? = nil
                  
                    if let appointmentJson = aRes?.json?["data"]
                    {
                        appointment = Appointments(json3: appointmentJson)
                    }
                   
                    completionHandler(appointment,nil)
                    
                }
                else{
                    completionHandler(nil,getErrMsg(json: aRes?.json))
                }
            }
            else{
                completionHandler(nil,getErrMsg(json: aRes?.json))
            }
        }
    }
}

