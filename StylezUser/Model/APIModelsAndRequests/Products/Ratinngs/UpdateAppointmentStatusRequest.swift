//
//  UpdateAppointmentStatusRequest.swift
//  StylezUser
//
//  Created by abcd on 17/04/2024.
//

import Foundation


struct UpdateAppointmentStatusRequest {
   
    let appointmentID:Int
    let appointmentStatus:Int
   
    
    func getRequestBody() -> [String:Any]{
        
        var details = [String:Any]()
       
        // 0-no rating,1-rating panding , 2-rating done,
        details["appointment_rating_status"] = appointmentStatus
       
        details["appointment_id"] = appointmentID
       
        
        return details
    }
    
}
