//
//  Appointments.swift
//  StylzWebkit
//
//  Created by WC_Macmini on 14/03/23.
//

import UIKit
import SwiftyJSON

public class Appointments: JSONAble {
    
    public var id : Int?
    public var reference_id : String?
    public var appointment_status : Int?
    public var customer_prepaid : Int?
    
    public var salon_id : Int?
    public var salon_name_ar : String?
    public var salon_name_en : String?
    public var salon_address : String?
    public var salon_address_region : String?
    public var salon_latitude : Double?
    public var salon_longitude : Double?
    public var salon_latitudeStirng :String?
    public var salon_longitudeString:String?
    public var salonRated :Bool?
    public var salonLogo :String?
    public var salonRating:Double?
    
    public var vat_reg_number : String?
    public var date : String?
    public var start_time : String?
    public var end_time : String?
    public var paid_amount : Double?
    public var service_amount : Double?
    
    
    public var customerId : Int?
    public var customerName : String?
    public var customerPhone : String?
    public var customerEmail : String?
    public var customerImage : String?
    
    public var employeeName : String?
    
    public var services = [ AppointmentService ]()
    public var billDetails = [ BillDetails ]()
    
    public var employee = [Employee]()
    
    public var appointmentRatingStatus:Int?
    
    public init(json2:JSON) { // for appointment details
        
        id = json2["id"].int
        reference_id = json2["reference_id"].string
        appointment_status = json2["appointment_status"].int
        customer_prepaid = json2["customer_prepaid"].int
        
        
        date = json2["date"].string
        start_time = json2["start_time"].string
        end_time = json2["end_time"].string
        paid_amount = json2["paid_amount"].double
        service_amount = json2["service_amount"].double
        employeeName = json2["employee_name"].string
        
        //  customerId = json["customer"].int
        
        
        if let choice = json2["shop"].dictionary {
            
            salon_id = choice["id"]?.int
            salon_name_ar = choice["salon_name_ar"]?.string
            salon_name_en = choice["salon_name_en"]?.string
            
            salon_address = choice["address"]?.string//
            salon_address_region = choice["region"]?.string
            salon_latitudeStirng = choice["latitude"]?.string//
            salon_longitudeString = choice["longitude"]?.string //
            vat_reg_number = choice["vat_reg_number"]?.string
        }
        
        
        if let choice = json2["customer"].dictionary {
            customerId = choice["id"]?.int
            customerName = choice["first_name"]?.string
            customerPhone = choice["phone"]?.string
            customerEmail = choice["email"]?.string
            customerImage = choice["image"]?.string
        }
        
        
            if let choice = json2["services"].array {
                for prodtJson in choice {
                    let item = AppointmentService(json2: prodtJson)
                    services.append(item)
                }
            }
        
        
        if let choice = json2["bill_details"].array {
            for prodtJson in choice {
                let item = BillDetails(json: prodtJson)
                billDetails.append(item)
            }
        }
    }
    
    
    
    public init(json:JSON) { // for history
        
        //print("appointmennt json")
        
        id = json["id"].int
        reference_id = json["reference_id"].string
        appointment_status = json["appointment_status"].int
        customer_prepaid = json["customer_prepaid"].int
        
        
        // salon_name_ar = json["salon_name_ar"].string
        //salon_name_en = json["salon_name_en"].string
        
        salon_id = json["shop_id"].int
        salonLogo = json["shop_logo"].string
        salon_name_en = json["shop_name"].string//
        salon_name_ar = json["shop_name"].string
        salonRated = json["salon_rated"].bool
        
        salon_address = json["shop_address"].string//
        salon_address_region = json["salon_address_region"].string
        salon_latitude = json["shop_latitude"].double//
        salon_longitude = json["shop_longitude"].double //
        vat_reg_number = json["vat_reg_number"].string
        
        date = json["date"].string
        start_time = json["start_time"].string
        end_time = json["end_time"].string
        paid_amount = json["paid_amount"].double
        service_amount = json["service_amount"].double
        employeeName = json["employee_name"].string
        //  customerId = json["customer"].int
        
        
        
        if let choice = json["customer"].dictionary {
            customerId = choice["id"]?.int
            customerName = choice["first_name"]?.string
            customerPhone = choice["phone"]?.string
            customerEmail = choice["email"]?.string
            customerImage = choice["image"]?.string
        }
        
          if let choice = json["services"].array {
                for prodtJson in choice {
                    let item = AppointmentService(json: prodtJson)
                    services.append(item)
                }
            }
        
        
        if let choice = json["bill_details"].array {
            for prodtJson in choice {
                let item = BillDetails(json: prodtJson)
                billDetails.append(item)
            }
        }
    }
    
    
    public init(json3:JSON) { // for rating view
        
        id = json3["appointment_id"].int
        appointment_status = json3["appointment_status"].int
        appointmentRatingStatus = json3["rating_status"].int
        
        if let details = json3["details"].array {
            for prodtJson in details {
                
                if let choice = prodtJson["shop"].dictionary {
                    //print("in details llopp shop")
                    salon_name_ar = choice["name_ar"]?.string
                    salon_name_en = choice["name_en"]?.string
                    
                    salon_id = choice["id"]?.int
                    salonLogo = choice["logo"]?.string
                    salonRating = choice["rating"]?.double
                    
                }
                
                if let choice = json3["customer_details"].dictionary {
                    customerId = choice["id"]?.int
                    customerName = choice["first_name"]?.string
                    customerPhone = choice["phone"]?.string
                    customerEmail = choice["email"]?.string
                    customerImage = choice["image"]?.string
                }
                
                if let choice = prodtJson["services"].array { // not using
                    for prodtJson in choice {
                        let item = AppointmentService(json2: prodtJson)
                        services.append(item)
                    }
                }
                
                
                if let choice = prodtJson["employee"].array {
                    for prodtJson in choice {
                        let item = Employee(json2: prodtJson)
                        employee.append(item)
                    }
                }
                
                break
                
            }
        }
    }
}
