//
//  EmployeeRatingRequest.swift
//  StylezUser
//
//  Created by abcd on 17/04/2024.
//

import Foundation


struct EmployeeRatingRequest {
   
    let appointmentID:Int
    let review:String
    let appointmentStatus:Int
    let ratings:[Rating]
    
    func getRequestBody() -> [String:Any]{
        
        var details = [String:Any]()
       
        // 0-no rating,1-rating panding , 2-rating done,
        details["appointment_rating_status"] = appointmentStatus
       
        details["appointment"] = appointmentID
       
        details["review"] = review
       
        details["employee_rating"] = getEmployeeRatingDic()
       
        return details
    }
    
    
    func getEmployeeRatingDic() -> ([[String:Any]]){
        var _ratings = [[String:Any]]()
        
        for rating in ratings {
            var data = [String:Any]()
            data["rating"] = rating.employeeRating
            data["employee_id"] = rating.employeeID
            _ratings.append(data)
        }
        
        return _ratings
    }
}


// MARK: - rating
struct Rating {
    let employeeID, employeeRating: Int
}
