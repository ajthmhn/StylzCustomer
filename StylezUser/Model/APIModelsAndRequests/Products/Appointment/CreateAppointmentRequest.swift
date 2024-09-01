//
//  CreateAppointmentRequest.swift
//  StylezUser
//
//  Created by abcd on 01/04/2024.
//

import Foundation
import StylesWebKit


struct CreateAppointmentRequest {
    
    let customerID:Int
    let branchID:Int
    let totalAmount:String
    let date:String
    let Starttime:String
    let services:[AppointmentService]?
    let isReorder:Bool
    let discountObj:Discount?
    let disocuntSource:String
    let isDicountAdded:Bool
    let discountedAmount:Double
    
    func getRequestBody() -> [String:Any]{
        
        let appointmentData = getAppointmentDetails()
        
        var details = [String:Any]()
        
        details["date"] = date
        details["start_time"] = Starttime
        details["appointment_details"] = appointmentData.0
        details["branch_id"] = appointmentData.1
        details["total_amount"] = totalAmount
        details["customer_id"] = customerID
        
        
        details["discount_source"] = disocuntSource
        
        //only if promo
        if isDicountAdded{
            details["discount_details"] = getDiscountObj()
        }
        
        return details
    }
    
    func getAppointmentDetails() -> ([[String:Any]], Int){
        
        if isReorder
        {
            return getAppointmentDetailsFromSerives()
        }
        else{
            return getAppointmentDetailsFromCart()
        }
    }
    
    
    func getAppointmentDetailsFromSerives() -> ([[String:Any]], Int){
        var appointment = [[String:Any]]()
        
        for all in services ?? []{
            var data = [String:Any]()
            data["service_id"] = all.service_id
            data["employee_id"] = all.employee_id
            appointment.append(data)
        }
        
        return (appointment, self.branchID)
    }
    
    func getAppointmentDetailsFromCart() -> ([[String:Any]], Int){
        var appointment = [[String:Any]]()
        var branchID = 0
        
        if let cartData = getCartData(){
            for all in cartData{
                var data = [String:Any]()
                data["service_id"] = all["service_id"] as? Int
                data["employee_id"] = all["customer_id"] as? Int
                branchID = all["shop_id"] as? Int ?? 0
                appointment.append(data)
            }
        }
        
       return (appointment, branchID)
    }
    
    
    func getDiscountObj() -> [String:Any]{
        
        var _discountObj = [String:Any]()
        
        
        if let discountObj{
            _discountObj["discount_id"] = discountObj.discountID
            _discountObj["name_en"] = discountObj.name_en
            _discountObj["name_ar"] = discountObj.name_ar
            _discountObj["discount_type"] = discountObj.discountType
            _discountObj["discount_value"] = discountObj.discountValue
            _discountObj["discounted_amount"] = discountedAmount
                
        }
        
        return _discountObj
    }
            
    
}

//
//{
//    "branch_id": 1,
//    "total_amount": "40.0",
//    "appointment_details": [
//        {
//            "employee_id": 5,
//            "service_id": 5
//        }
//    ],
//    "date": "2024-05-28",
//    "discount_details": {
//        "discount_id": 7,
//        "name_en": "Hair Cut",
//        "name_ar": "رئيسي",
//        "discount_type": 1,
//        "discount_value": 20.0,
//        "discounted_amount": 30.0
//    },
//    // "total_amount": 1425
//    "start_time": "14:00",
//    "customer_id": 18
//}
