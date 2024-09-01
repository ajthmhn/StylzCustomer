//
//  GetTimingsRequest.swift
//  StylezUser
//
//  Created by mac on 18/03/2024.
//

import Foundation
import StylesWebKit


struct GetTimingsRequest {
    
    let services:[AppointmentService]?
    let isReschedule:Bool
    let isReorder:Bool
    let date:String
    let branchId:Int
    
     func getRequestBody() -> [String:Any]{
    
        let appointment = getAppointment()
        
        var details = [String:Any]()
        details["date"] = date
        details["appointment_details"] = appointment.0
        details["branch_id"] = appointment.1
        
        return details
    }
    
    
    
     func getAppointment() ->  ([[String:Any]], Int){
        
         var appointment = [[String:Any]]()
        
         if (isReschedule || isReorder), let services{
            for all in services{
                var data = [String:Any]()
                data["service_id"] = all.service_id
                data["employee_id"] = all.employee_id
                appointment.append(data)
            }
            //print("inn reshecdule seervices \(appointment)")
            return (appointment, self.branchId)
        }
         else{
        
        var branch_Id = 0
           
             if let cartData = getCartData(){
                 for all in cartData{
                     var data = [String:Any]()
                     
                     data["service_id"] = all["service_id"] as? Int
                     
                     data["employee_id"] = all["customer_id"] as? Int
                     
                     branch_Id = all["shop_id"] as? Int ?? 0
                     
                     appointment.append(data)
                 }
             }
             
            return (appointment, branch_Id)
        }
    }
}



