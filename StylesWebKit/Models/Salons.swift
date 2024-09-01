//
//  Salons.swift
//  StylesWebKit
//
//  Created by Ajith Mohan on 12/09/23.
//

import UIKit
import SwiftyJSON

public class Salons: JSONAble {
    public var id : Int?
    public var name_en : String?
    public var name_ar : String?
    public var address_region : String?
    public var vat_reg_number : String?
    public var invoice_address : String?
    public var insta_link : String?
    public var salon_rating : Double?
    public var latitude : String?
    public var longitude : String?
    
//new
    public var address:String?
    public var gender : Int?
    public var salon_images = [String]()
    public var is_favorite : Bool?
    public var logo:String?
    public var phone:String?
   
    
    public init(json:JSON) {
        id = json["id"].int
        name_en = json["name_en"].string
        name_ar = json["name_ar"].string
        address_region = json["region"].string
        vat_reg_number = json["vat_reg_number"].string
       // invoice_address = json["address_region"].string
        invoice_address = json["address"].string
        insta_link = json["insta_link"].string
        salon_rating = json["salon_rating"].double
        latitude = json["latitude"].string
        longitude = json["longitude"].string
        address = json["address"].string
        gender = json["gender"].int
        is_favorite = json["is_favorite"].boolValue
        phone = json["phone"].stringValue
        logo = json["logo"].stringValue
        
        if let imagess = json["images"].array {
            for prodtJson in imagess {
                salon_images.append(prodtJson.stringValue)
            }
        }
 
        
     }
}

//
//"insta_link" : "",
//"salon_rating" : 0,
//"region" : "Makkah Saudi Arabia",
//"gender" : 1,
//"name_en" : "makkah branch",
//"name_ar" : "makkah branch",
//"logo" : "https:\/\/stylz-stg.s3.me-south-1.amazonaws.com\/shop_logo\/logo.png",
//"address" : "makkah shop",
//"id" : 5,
//"longitude" : "39.8173363999999900",
//"phone" : "123456789",
//"is_favorite" : false,
//"latitude" : "21.4240968000000000",
//"images" : [
//  "https:\/\/stylz-stg.s3.me-south-1.amazonaws.com\/shared_images\/barbar1.jpeg",
//  "https:\/\/stylz-stg.s3.me-south-1.amazonaws.com\/shared_images\/barbar.jpeg"
//],
//"vat_reg_number" : "123432123432123"
