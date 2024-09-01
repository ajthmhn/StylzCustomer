//
//  GetAppointmentDetailsResource.swift
//  StylezUser
//
//  Created by abcd on 02/04/2024.
//


import Foundation
import StylesWebKit
import SwiftyJSON



struct GetAppointmentDetailsResource{
    
    func getAAppointmentDDetailss(request:GetAppointmentDetailsRequest,completionHandler:@escaping (_ appointments:[Appointments]?,_ errMsg:String?)->()) {
      
        StylzAPIFacade.shared.getAAppointmentDDetailss(appointmentID: request.appointmentID) { (aRes) in
          
            //print("json \(aRes?.json)")
        
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    var  myAppointmentData = [Appointments]()
                    
                    if let data = aRes?.json?["data"].array{
                        
                        for m in data{
                            let booking = Appointments(json2: m)
                            myAppointmentData.append(booking)
                        }
                    }
                    completionHandler(myAppointmentData, nil)
                }
                else{
                    completionHandler(nil,getErrMsg(json: aRes?.json)) //nil
                }
            }
            else{
                completionHandler(nil, getErrMsg(json: aRes?.json))
            }
        }
    }
}


