//
//  StylzAPIFacade.swift
//  PartyManager
//
//  Created by islet on 14/12/16.
//  Copyright © 2016 islet. All rights reserved.
//

//
//  StylzAPIFacade.swift
//  Party
//
//  Created by Isletsystems on 22/09/16.
//  Copyright © 2016 Party. All rights reserved.
//

import UIKit
import SwiftyJSON


//Given token not valid for any token type ->
//Authentication credentials were not provided. (Error msg replaced)
//
//
//authentication credential:
//
//{
//    "detail": "Authentication credentials were not provided."
//}

public typealias StylzAPICompletion = (StylzAPIResponse?) -> Void

public class StylzAPIFacade: NSObject {
    struct StylzAPIFacadeConst{
        static let clientId = 2
        static let clientKey = "FEZbPoNvx3vMxP2H1UsP1kCTTVmbxaNlbSuqo7J0"
    }
    public var session : StylzAPISession?
    public class var shared : StylzAPIFacade {
        struct Singleton {
            static let instance = StylzAPIFacade()
        }
        return Singleton.instance
    }
    
    override init() {
        
        StylzAPIProviderFactory.offlineMode = false
        session = StylzAPISession.init()
    }
    
    public func setOfflineMode(_ flag:Bool) {
        StylzAPIProviderFactory.offlineMode = flag
    }
  
    
    public func getCategory( gender:Int,keyValue:Int?,key:String , completion:StylzAPICompletion?) {
       
        StylzAPIProviderFactory.sharedProvider.request(.getCategory(gender: gender,keyValue: keyValue, key: key)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func searchAll(searchTerm:String, gender:Int,searchType:[String], lat:String, long:String, completion:StylzAPICompletion?)
    {
        StylzAPIProviderFactory.sharedProvider.request(.searchAll(gendr: gender, searchTerm: searchTerm, searchType: searchType,lat:lat,long:long)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func getServices(id:Int ,gender: Int , employeeId:Int?, categoryID:Int?, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getservices(shopId: id, gender: gender, employeeID:employeeId,categoryID: categoryID)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func getEmployees(lat:String,lon:String,gender:Int,branchId:Int?, employeeId:Int?, servicesID:Int?,  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getEmployees(lat: lat, lon: lon, gender: gender,branchId:branchId ,EmployeeID: employeeId,servicesID: servicesID)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func getOffers(id:Int ,  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getOffers(shopId: id)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func checkAvailability(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.checkAvailability(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func top10Salons(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.top10Slons(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func allBarbers(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.allBarber(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func orderHIstory(gender:Int,  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.orderHIstory(gender: gender)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func getAppointments(date:String,gender : Int, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getAppointMents(date: date,gender: gender)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    
    public func updateProfile(profDet:[String:Any],  completion:StylzAPICompletion?) {
        
        StylzAPIProviderFactory.sharedProvider.request(.updateProfile(profDetails: profDet)) { result in
        
            switch result {
            
            case let .success(moyaResponse):
            
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                
//                    if YKRes.json?["status"].intValue == 200 {
//                        if YKRes.json != nil{
//                            self.extractUserDetails(YKRes.json!)
//                        }
//                    }
                   
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                 
                    return
                }
                
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func getNotifications(page : Int,gender : Int, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getNotifications(page: page, gender: gender)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
   
    
    
    public func lockTimeSlote(profDet:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.lockTimeSlote(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func unlockTime(id:String, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.unlockTime(id: id)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func placeOrder(profDet:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.placeOrder(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    public func applyPrmo(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.applyPromo(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    
    public func mySalons(gender : Int, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.mySalons(gender: gender)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    public func checkFavourite(id: Int,gender: Int,  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.checkFaourite(shopid: id, gender: gender)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func updateToken(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.updateToken(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                
                let jsonData = moyaResponse.data
                
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
            
        }
    }
    
    public func resetSession() {
        self.session?.token = nil
    }
    
    public func extractUserSession(_ json:JSON) {
        //            if let data = json["data"].dictionary{
        //                self.session?.token = data["token"]?.stringValue
        //                self.session?.UserId = data["user_id"]?.intValue
        //            }
       
        
                        self.session?.token = json["token"].stringValue
                        self.session?.UserId = json["userId"].intValue
    
       
        //print("~ token: \(self.session?.token), userid: \(self.session?.UserId)")
        
        // token
        
        
    }
        
        public func extractUserDetails(_ json:JSON) {
//            if let data = json["data"].dictionary{
//                if let user = data["user_details"]{
//                    let users = User(json: user)
//                    self.session?.currentUser = users
//                }
//            }
//         
            if let data = json["data"].dictionary{
                         if let user = data["customer"]{
                             let users = User(json: user)
                             self.session?.currentUser = users
                         }
                     }
    
            
            //customer
        }

    
    public func extractUserDetailsFromPofile(_ json:JSON) {
        let user = User(json:json["data"])
        self.session?.currentUser = user
    }

    // MARK: - image path
    public func urlForImage(imagePath:String) -> URL?{
        let path = StylzAPIConfig.BaseUrl.baseServerpath + "uploads/" + imagePath
        return URL(string: path)
    }
}

//MARK: - product

extension StylzAPIFacade{
  
 
    //MARK: - discount
    
    public func getDiscount(completion:StylzAPICompletion?) {
        
        StylzAPIProviderFactory.sharedProvider.request(.getDiscount) { result in
            
            switch result {
          
            case let .success(moyaResponse):
             
                let jsonData = moyaResponse.data
                
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    return
                }
                
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
                
            }
        }
    }
    
    
    
    //MARK: - ratings
    
    
    public func addRatings(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.addRating(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    public func updateAppointmentStatus(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.updateAppointmentStatus(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func createEmployeeRating(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.createEmployeeRating(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func getAppointmentRatingDetails(completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getAppointmentRatingDetails) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    //MARK: get brances
    public func getBranches(gender:Int,lat:Double?,lon:Double?, customerID:Int?, completion:StylzAPICompletion?) {
        
        StylzAPIProviderFactory.sharedProvider.request(.getBranches(gender:gender , lat: lat, lon: lon, customerID: customerID)) { result in
            
            switch result {
            case let .success(moyaResponse):
                
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    
                    //print("fetced response \(jsonData),")
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
        
    }
//MARK: make fav
    public func makeFavourite(id : Int, status : Int , gender: Int,  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.makeFavourite(id: id, status: status, gender: gender)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
}

//MARK: - authenntication and login
extension StylzAPIFacade{
    
    public func signUp(profDet:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.signUp(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                  
                    //----
                    if YKRes.json?["status"].intValue == 201 {
                        
                                if YKRes.json != nil{
                                    self.extractUserSession(YKRes.json!)
                                }
                    }
            
                    
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
       
    public func login(profDet:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.login(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    if YKRes.json?["status"].intValue == 200 {
//                        if let data = YKRes.json?["data"].dictionary{
//                            let verified = data["email_verification_status"]?.boolValue
//                            if verified == true{
//                                if YKRes.json != nil{
//                                    self.extractUserSession(YKRes.json!)
//                                    self.extractUserDetails(YKRes.json!)
//                                }
//                            }
//                        }
//                    }
                    //if let verified = YKRes.json?["email_verified"].boolValue{
                      //                    if verified == true{
                                              if YKRes.json != nil{
                                                  self.extractUserSession(YKRes.json!)
                                              //    self.extractUserDetails(YKRes.json!)
                                              }
                                      //    }
                                      }
                    
                    
                    
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
//    public func loginPhone(profDet:[String:Any], completion:StylzAPICompletion?) {
//        StylzAPIProviderFactory.sharedProvider.request(.loginPhone(profDetails: profDet)) { result in
//            switch result {
//            case let .success(moyaResponse):
//                let jsonData = moyaResponse.data
//                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
//                    YKRes.statusCode = moyaResponse.statusCode
//                    completion?(YKRes)
//                    return
//                }
//            case .failure(_):
//                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
//            }
//        }
//    }
    
    public func logout(completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.logout) { result in
            switch result {
            case let .success(moyaResponse):
                //print("logout succeeded")
              
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
              //print("logout ffailed")
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    public func quickLoginVerifyOtp(profDet:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.verifyOtp(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["status"].intValue == 200 { // new
                        if YKRes.json != nil{
                            //print("extracting user sessionn in verify otp")
                            self.extractUserSession(YKRes.json!)
                       //     self.extractUserDetails(YKRes.json!)
                        }
                    }
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func getCountry(completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getCountry) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func verifyLoginOtp(profDet:[String:Any], completion:StylzAPICompletion?) {
        
        StylzAPIProviderFactory.sharedProvider.request(.verifyLoginOtp(profDetails: profDet)) { result in
            switch result {
          
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["status"].boolValue == true {
//                        if YKRes.json != nil{
//                            self.extractUserSession(YKRes.json!)
//                            self.extractUserDetails(YKRes.json!)
//                        }
                    }
                    completion?(YKRes)
                    return
                }
                
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func sendOtpLogin(profDet:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.sendOtpLogin(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    

    public func updatePassword(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.updatePassword(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func changePassword(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.changePassword(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                  
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    
    
    //MARK: - delete
    
    public func deleteAccount(completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.deletAccount) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: - aappointments
    
    public func getAAppointmentDDetailss(appointmentID : Int, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getAppointmentDetails(appoinntmentID:  appointmentID)) { result in

            switch result {
            case let .success(moyaResponse):
                
                let jsonData = moyaResponse.data
               
                
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData)
                    as? StylzAPIResponse {
                    
                    YKRes.statusCode = moyaResponse.statusCode
                    
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            
                
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
   
    public func getAllAppointments(gender : Int, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getAllAppointmnents(gender: gender)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func resceduleAppointment(id : Int,date:String, startTime: String, endTime : String, salonId : Int, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.resceduleAppoint(id: id, date: date, startTime: startTime, endTime: endTime, salonId: salonId)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func cancelAppointment(id:Int, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.cancelAppointment(id: id)) { result in
            switch result {
            case let .success(moyaResponse):
                
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData)
                    as? StylzAPIResponse {
                    
                    YKRes.statusCode = moyaResponse.statusCode
                    
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
}

//MARK: - profile
extension StylzAPIFacade{
    
   
    
    
    
    //MARK: forgot password
    public func forgotPassword(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.forgotPassword(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: upload image
    public func uploadImage(profDet:[String:Any], completion:StylzAPICompletion?) {
        
        
        
        //return .uploadMultipart(formData)
        
        StylzAPIProviderFactory.sharedProvider.request(.uploadProfileImage(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: get customer info
    public func getCustomerInformation( completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getCustomerInformation) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    
                    //----
                    if YKRes.json?["status"].intValue == 200 {
                        if YKRes.json != nil{
                            //print("~ extrating  user id ")
                            // self.extractUserSession(YKRes.json!)
                            self.extractUserDetails(YKRes.json!)
                        }
                    }
                    //
                    
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: update phone
    public func updatePhone(profDet:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.updatePhone(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: - update email
    public func updateEmail(profDet:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.updateEmail(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    //MARK: adddress
    public func createAddress(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.createAddress(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func addressList(completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.addressList) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func deleteAddress(id:Int, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.deleteAddress(page: id)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    
    //MARK: - not using
    public func createCard(profDet:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.createCard(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    //MARK: - not using
    public func getCard(completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getCard) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
  
    //MARK: -  not usinng
    public func deleteCard(id : Int, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.deleteCard(id: id)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Authentication credentials were not provided."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }

}
 
