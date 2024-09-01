//
//  Employee.swift
//  StylzWebkit
//
//  Created by WC_Macmini on 06/03/23.
//


import UIKit
import SwiftyJSON

public class Employee: JSONAble {
    public var id : Int?
    public var employee : Int?
    public var price : Double?
    public var first_name : String?
    public var last_name : String?
    public var reference_id : String?
    public var image : String?
    public var employee_rating : String?
    public var phone : String?
    public var email : String?
    public var branchNameEn : String?
    public var branchNameAr : String?
    public var branchId : Int?
    public var branchRating : Double?
    public var branchAddress : String?
    
    public var employee__first_name : String?
    public var employee__last_name : String?
   
    public var total_amount : String?
  
    public var services = [ Services ]()
    
    //for rating
    public   var empRating = 1
    
    public init(json:JSON) {
        
       // employee_rating = json["rating"].intToSafeString()
        employee_rating =  String.init(format: "%.1f",json["rating"].double ?? 0.0)
       
        employee = json["employee"].int
        reference_id = json["reference_id"].string
        
        employee__first_name = json["employee__first_name"].string
        employee__last_name = json["employee__last_name"].string
        total_amount = json["total_amount"].intToSafeString()
        
        
        
        if let choice = json["employee_services"].array {
            //print("~ in elpyee services 1")
            
            for prodtJson in choice {
                let user = prodtJson["service"]
                //print(" ~ in elpyee services 2")
                let item = Services(json: user)
                services.append(item)
                
            }
        }
        
        //        if let choice = json["employee_services"].dictionary {
        //            //print("~ in elpyee services 1")
        //             if let _services = choice["service"]?.array {
        //                 //print(" ~ in elpyee services 2")
        //                    for prodtJson in _services {
        //                    let item = Services(json: prodtJson)
        //                    services.append(item)
        //                }
        //            }
        //        }
        
        
        
        id = json["id"].int
        
        image = json["image"].string
        phone = json["phone"].string
        price = json["price"].double
        
        if let user = json["user"].dictionary {
            first_name = user["first_name"]?.string
            last_name = user["username"]?.string
            email = user["email"]?.string
        }
        
        
        
        if let shops = json["shop"].dictionary {
            self.branchId = shops["id"]?.int
            self.branchNameEn = shops["name_en"]?.string
            self.branchNameAr = shops["name_ar"]?.string
            
            self.branchRating = shops["shop_rating"]?.double
            self.branchAddress = shops["address"]?.string
            
            
        }
        
    }
    
    
    public init(json2:JSON) {
        
        first_name = json2["employee__user__first_name"].string
        last_name = json2["employee__user__last_name"].string
        id = json2["employee__id"].int
        image = json2["employee__image"].string
        
     
    }
}
