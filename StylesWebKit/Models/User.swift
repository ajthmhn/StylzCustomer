//
//  User.swift
//  StylzWebkit
//
//  Created by WC_Macmini on 06/03/23.
//

import UIKit
import SwiftyJSON

public class User: JSONAble {
    public var userId : Int?
    public var first_name : String?
    public var last_name : String?
    public var phone : String?
    public var image : String?
    public var email : String?
    public var dob : String?
    public var gender : Int?
    public var occupation : String?
    public var age : Int?
    public var country : String?
    public var country_id : Int?
    public var email_verified:Bool?
    
    public var phone_verified:Bool?
    
    public init(json:JSON) {
        userId = json["id"].int
        first_name = json["first_name"].string
        last_name = json["last_name"].string
        phone = json["phone"].string
        image = json["image"].string 
        email = json["email"].string
        dob = json["dob"].string
        gender = json["gender"].int
        occupation = json["occupation"].string
        age = json["age"].int
        country = json["country_name"].string
        country_id = json["country_id"].int
      
        email_verified = json["email_verified"].boolValue
        phone_verified = json["phone_verified"].boolValue
        
  }
        
    public func dicValue() -> [String:Any] {
        var userDic = [String:Any]()
        userDic["id"] = userId
        userDic["first_name"] = first_name
        userDic["last_name"] = last_name
        userDic["phone"] = phone
        userDic["image"] = image
        userDic["email"] = email
        userDic["dob"] = dob
        userDic["gender"] = gender
        userDic["occupation"] = occupation
        userDic["age"] = age
        userDic["country_name"] = country
        userDic["country_id"] = country_id
        userDic["email_verified"] = email_verified
        userDic["phone_verified"] = phone_verified
  
        return userDic
    }
}

