//
//  UpdateAppointmentStatusResource.swift
//  StylezUser
//
//  Created by abcd on 17/04/2024.
//

import Foundation

import StylesWebKit
import SwiftyJSON


struct UpdateAppointmentStatusResource{
    
    func updateAppointmentStatus(request:UpdateAppointmentStatusRequest,completionHandler:@escaping (_ errorMsg:String?)->()) {
        
        StylzAPIFacade.shared.updateAppointmentStatus(profDet: request.getRequestBody()){ (aRes) in
            
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

