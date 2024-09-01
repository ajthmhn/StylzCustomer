//
//  NOtifications.swift
//  StylzWebkit
//
//  Created by WC_Macmini on 20/03/23.
//

import UIKit
import SwiftyJSON

public class NOtifications: JSONAble {
    public var id : Int?
    public var title : String?
    public var message : String?
    public var created_at : String?
  public  var appointment : Appointments?
    
    
    public init(json:JSON) {
        id = json["id"].int
        title = json["title"].string
        message = json["message"].string
        created_at = json["created_at"].string
    
        //   created_at = json["start_time"].string
        
            //print("appiointmnet")
        self.appointment = Appointments(json: json["appointment"])
        
    }
    
}

