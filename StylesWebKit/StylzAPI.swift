//
//  StylzAPI.swift
//  Party
//
//  Created by Isletsystems on 22/09/16.
//  Copyright © 2016 Party. All rights reserved.
//

import UIKit
import Moya

public enum StylzAPI {
    
    case getCustomerInformation
    case uploadProfileImage(profDetails:[String:Any])
    
    //case changePhone(profDetails:[String:Any])
    // case changeEmail(profDetails:[String:Any])
    case getAppointmentDetails(appoinntmentID:Int)
    
    // login and authentication
    case signUp(profDetails:[String:Any])
    case login(profDetails:[String:Any])
    case loginPhone(profDetails:[String:Any])
    case verifyOtp(profDetails:[String:Any])
    case verifyLoginOtp(profDetails:[String:Any])
    case sendOtpLogin(profDetails:[String:Any])
    case logout
    case getCountry
    case forgotPassword(profDetails:[String:Any])
    case updatePassword(profDetails:[String:Any])
    case changePassword(profDetails:[String:Any])
    
    //profile
    case updateProfile(profDetails:[String:Any])
    case getNotifications(page:Int, gender : Int)
    case createAddress(profDetails:[String:Any])
    case addressList
    case deleteAddress(page:Int)
    case updatePhone(profDetails:[String:Any])
    case updateEmail(profDetails:[String:Any])
    
    case deletAccount
 
    
    //product
    case getCategory(gender:Int, keyValue:Int?, key:String)
    
    case searchAll(gendr:Int, searchTerm:String, searchType:[String],lat:String,long:String)
    case getservices(shopId:Int, gender : Int, employeeID:Int?, categoryID:Int?)
    case getEmployees(lat:String,lon:String, gender:Int, branchId:Int?, EmployeeID:Int?,servicesID:Int?)
    
    case getOffers(shopId:Int)
    
    case checkAvailability(profDetails:[String:Any])
    case top10Slons(profDetails:[String:Any])
    case allBarber(profDetails:[String:Any])
    
    case orderHIstory(gender:Int)
    
    case getAppointMents(date:String, gender : Int)
    case getAllAppointmnents(gender: Int)
    case resceduleAppoint(id:Int, date:String, startTime:String, endTime:String, salonId: Int)
    case cancelAppointment(id:Int)
    case lockTimeSlote(profDetails:[String:Any])
    case unlockTime(id:String)
    case placeOrder(profDetails:[String:Any])
    case createCard(profDetails:[String:Any])
    case getCard
    case deleteCard(id : Int)
    case applyPromo(profDetails:[String:Any])
    
    case getBranches(gender:Int, lat:Double?, lon:Double?, customerID:Int?)
    
    case makeFavourite(id : Int, status:Int, gender : Int)
    case mySalons(gender : Int)
    case checkFaourite(shopid : Int, gender: Int)
    case updateToken(profDetails:[String:Any])
    
    case getDiscount
 
    case addRating(profDetails:[String:Any])
    case getAppointmentRatingDetails
    case updateAppointmentStatus(profDetails:[String:Any])
    case createEmployeeRating(profDetails: [String:Any])
    
}


extension StylzAPI: TargetType {
    
    public var headers: [String : String]? {
        return nil
    }
    
    var base: String {
        // return  StylzAPIConfig.BaseUrl.baseServerpath + "api/"
        return  StylzAPIConfig.BaseUrl.baseServerpath
        
    }
    
    public var baseURL: URL {
        return URL(string: base)!
    }
    
    
    public var path: String {
        switch self {
            
            
        case .getCustomerInformation:
            return "/customer/api/get"
     
        case .uploadProfileImage:
            return "/customer/api/customer-image/update"
            
            // login and authentication
        case .signUp(_): //new
            return "/accounts/api/sign-up/"
            
        case .login(_): //new
            return "/accounts/api/sign-in/"
            
        case .logout: //new
            return "/accounts/api/sign-out/"
            
        case .loginPhone(_): // not using
            return "login/send-otp"
            
        case .verifyOtp(_): // new
            return "/accounts/api/quick/login"
            
        case .getCountry: //new
            return "/accounts/api/country/list"
            
        case .verifyLoginOtp: //new
            return "/accounts/api/confirm/otp"
            
        case .sendOtpLogin(_): //new
            return "/accounts/api/send/otp"
            
        case .forgotPassword: //new
            return "/accounts/api/forget-password/"
            
        case .updatePassword: //new
            return "accounts/api/reset-password/"
            
            
            //MARK: profile
            
            //profile update
        case .updatePhone: //new
            return "/customer/api/customer-phone/change"
            
        case .updateEmail: //new
            return "/customer/api/customer-email/change"
            
        case .changePassword(_): //new
            return "/accounts/api/change-password"
            
        case .updateProfile(_): // new
            return "/customer/api/customer-profile/update"
      
        case .deletAccount:
            return "/accounts/api/delete-account"
      
            
            //notifications
        case .getNotifications:
            return "/accounts/api/notification/list"
            
            // address
        case .createAddress(_): //new
            return "/customer/api/customer-address/create"
        case .addressList:
            return "/customer/api/customer-address/list"
        case .deleteAddress: //new
            return "/customer/api/customer-address/delete"
            
            //MARK: - history
        case .orderHIstory: //new
            return "/appointment/api/history"
            
            
            //MARK: product
        case .getCategory: //new
            return "/service/api/category/list"
            
        case .getBranches: //new
            return "/shop/api/list"
            
        case .makeFavourite(_,_,_): //new
            return "/shop/api/favorite/add"
      
        case .mySalons(_): //new
            return "/shop/api/my-salons"
            
            
        case .top10Slons:
            return "top-salons"
            
        case .allBarber:
            return "salon/list"
            
        case .checkFaourite(_,_):
            return "/shop/api/favorite/list"
            
            
        case .getEmployees: //new
            return "/employee/api/list"
            
     
        case .searchAll:
            return "/shop/api/search-all"
        
        case .getservices: //new
            return "/service/api/list"
        
        case .getOffers://new
            return "/discount/api/list"
            
            
            // MARK : - appointments
        case .checkAvailability: //new
            return "/appointment/api/availability"
            
        case .resceduleAppoint: // neew
            return "/appointment/api/reschedule"
            
            
            
        case .getAppointMents: //new
            return "/appointment/api/list"
            
        case .getAllAppointmnents(_)://
            return "/appointment/api/list"
            
        case .getAppointmentDetails:
            return "/appointment/api/detail"
            
        case .cancelAppointment:
            return "/appointment/api/cancel"
            
            
        case .lockTimeSlote:
            return "/appointment/api/create"
            
        case .unlockTime:
            return "appointment/delete-request"
            
        case .placeOrder: //new
         return "/appointment/api/confirmation"
         
            
            //MARK: - discount
        case .applyPromo:
            return "/discount/api/get/promo"
         
        case .getDiscount:
            return "/superadmin/api/global_settings/"
        
        case .updateToken(_):
            return "/accounts/api/fcm/token/refresh"
            
       
         //MARK: - rating
            
        case .addRating:
            return  "/shop/api/ratings/create"
          
        case .getAppointmentRatingDetails:
            return "/appointment/api/rating"
      
        case .updateAppointmentStatus:
            return "/appointment/api/rating/update"
     
        case .createEmployeeRating:
            return "/employee/api/ratings/create"
        
            
            //not using
        case .createCard:
            return "customer-card/create"
        case .getCard:
            return "customer-card/list"
        case .deleteCard:
            return "customer-card/delete"
            
            
            
        }
    }
    
    
    public var method: Moya.Method {
        switch self {
        case
            
            //profile -- new
                .uploadProfileImage(_),
                .updateProfile(_),
                .createAddress(_),
                .deleteAddress(_),
                .updatePhone(_),
                .updateEmail(_),
                .changePassword(_),
                .deletAccount,
               
            
            //login and authentication
                .signUp(_),
                .login(_),
                .loginPhone(_),
                .verifyOtp(_),
                .verifyLoginOtp(_),
                .sendOtpLogin(_),
                .forgotPassword(_),
                .updatePassword(_),
                .logout,
            
            
            //product
                .checkAvailability(_),
                .top10Slons(_),
                .allBarber(_),
            
                .resceduleAppoint,
                .lockTimeSlote(_),
                .unlockTime(_),
                .placeOrder(_),
            
                .createCard(_),
                .getCard,
                .deleteCard(_),
            
                .applyPromo(_),
                .makeFavourite(_,_,_),
              
                .addRating,
                .updateAppointmentStatus,
                .createEmployeeRating,
                .updateToken(_):
              
            return .post
     
            
        case
            //login and authenticationn
                .getCountry,
            
            //product
                .cancelAppointment(_),
                .getBranches,
                .mySalons(_),
                .getCategory,
                .getservices,
                .checkFaourite,
                .getEmployees,
                .getOffers,
                .orderHIstory,
                .getAllAppointmnents,
                .getAppointMents,
                .getAppointmentDetails(_),
                .searchAll,
                .getDiscount,
                .getAppointmentRatingDetails,
            
            //profile
                .addressList,
                .getCustomerInformation, //new
                .getNotifications:
            
            
            return .get
            
            //            return .put
            
        }
    }
    
    public var parameters: [String:Any]? {
        switch self {
            
            //profile
        case .getCustomerInformation: //new
            return nil
            
        case .uploadProfileImage(let profDetails)://new
            return profDetails
        case .changePassword(let profDet):
            return profDet
            
        case .updateProfile(let profDet):
            return profDet
            
        case .getNotifications:
            return nil
            
        case .createAddress(let profDet):
            return profDet
        case .addressList:
            return nil
        case .deleteAddress(let page):
            return ["address_id":page]
        case .updatePhone(let profDet):
            return profDet
        case .updateEmail(let profDet):
            return profDet
            
        case .deletAccount:
            return nil
      
            
            //login
        case .signUp(let profDet):
            return profDet
        case .login(let profDet):
            return profDet
        case .logout:
            return nil
        case .loginPhone(let profDet):
            return profDet
        case .verifyOtp(let profDet):
            return profDet
        case .getCountry:
            return nil
        case .verifyLoginOtp(let profDet):
            return profDet
        case .sendOtpLogin(let profDet):
            return profDet
        case .forgotPassword(let profDet):
            return profDet
        case .updatePassword(let profDet):
            return profDet
            
            
            //product
            
            
        case .getBranches:
            return nil
            
        case .getCategory:
            return nil
            
        case .searchAll:
            return nil
            
        case .getservices:
            return nil
            
        case .getEmployees:
            return nil
            
        case .getOffers(let shopId):
            return ["shop_id":shopId]
        case .checkAvailability(let profDet):
            return profDet
        case .top10Slons(let profDet):
            return profDet
        case .allBarber(let profDet):
            return profDet
            
        case .orderHIstory:
            return nil
            
        case .getAppointMents:
            return nil
            
        case .getAppointmentDetails:
            return nil
            
        case .getAllAppointmnents:
            return nil
            
        case .resceduleAppoint(let id, let date, let time,_,_):
            return ["appointment_id":id,
                    "date":date, "start_time":time]
            
        case .cancelAppointment:
            return nil
            
        case .lockTimeSlote(let profDet):
            return profDet
            
        case .unlockTime(let date):
            return ["reference_id":date]
            
        case .placeOrder(let profDet):
            return profDet
        case .createCard(let profDet):
            return profDet
        case .getCard:
            return nil
        case .deleteCard(let date):
            return ["card_id":date]
            
        case .applyPromo(let profDet):
            return profDet
            
        case .mySalons:
            //    return ["gender" : gender]
            return nil
            
        case .makeFavourite(let id, let status, let gender):
            return ["shop_id":id,"favorite_status":status, "gender" : gender]
            
        case .checkFaourite:
            return nil
        case .updateToken(let profDet):
            return profDet
            
        case .getDiscount:
            return nil
    
        case .addRating(let profDetails):
            return profDetails
            
        case .getAppointmentRatingDetails:
            return nil
        
        case .createEmployeeRating(let profDetails):
            return profDetails
      
        case .updateAppointmentStatus(let profDetails):
            return profDetails
        
        }
    }
    
    public var sampleData: Data {
        switch self {
            
        case .getCustomerInformation:
            return stubbedResponse("")
            
        case .uploadProfileImage:
            return stubbedResponse("")
            
            
        case .signUp:
            return stubbedResponse("")
        case .login:
            return stubbedResponse("")
        case .logout:
            return stubbedResponse("")
        case .loginPhone:
            return stubbedResponse("")
        case .verifyOtp:
            return stubbedResponse("")
        case .getCountry:
            return stubbedResponse("")
        case .verifyLoginOtp:
            return stubbedResponse("")
        case .sendOtpLogin:
            return stubbedResponse("")
        case .getCategory:
            return stubbedResponse("")
        case .searchAll:
            return stubbedResponse("")
        case .getservices:
            return stubbedResponse("")
        case .getEmployees:
            return stubbedResponse("")
        case .getOffers:
            return stubbedResponse("")
        case .checkAvailability:
            return stubbedResponse("")
        case .top10Slons:
            return stubbedResponse("")
        case .allBarber:
            return stubbedResponse("")
        case .orderHIstory:
            return stubbedResponse("")
        case .getAppointMents:
            return stubbedResponse("")
        case .getAllAppointmnents:
            return stubbedResponse("")
        case .resceduleAppoint:
            return stubbedResponse("")
        case .cancelAppointment:
            return stubbedResponse("")
        case .updateProfile:
            return stubbedResponse("")
        case .getNotifications:
            return stubbedResponse("")
        case .createAddress:
            return stubbedResponse("")
        case .addressList:
            return stubbedResponse("")
        case .deleteAddress:
            return stubbedResponse("")
        case .updatePhone:
            return stubbedResponse("")
        case .updateEmail:
            return stubbedResponse("")
        case .lockTimeSlote:
            return stubbedResponse("")
        case .unlockTime:
            return stubbedResponse("")
        case .placeOrder:
            return stubbedResponse("")
        case .createCard(_):
            return stubbedResponse("")
        case .getCard:
            return stubbedResponse("")
        case .deleteCard:
            return stubbedResponse("")
        case .applyPromo:
            return stubbedResponse("")
        case .forgotPassword:
            return stubbedResponse("")
        case .updatePassword:
            return stubbedResponse("")
        case .getBranches:
            return stubbedResponse("")
        case .changePassword:
            return stubbedResponse("")
        case .makeFavourite:
            return stubbedResponse("")
        case .mySalons:
            return stubbedResponse("")
        case .checkFaourite:
            return stubbedResponse("")
        case .updateToken:
            return stubbedResponse("")
        case .getAppointmentDetails:
            return stubbedResponse("")
            
        case .getDiscount:
            return stubbedResponse("")
     
        case .addRating:
            return stubbedResponse("")
        case .getAppointmentRatingDetails:
            return stubbedResponse("")
        case .createEmployeeRating:
            return stubbedResponse("")
        case .updateAppointmentStatus:
            return stubbedResponse("")
   
        case .deletAccount:
            return stubbedResponse("")
   
            
            
        }
    }
    
  //MARK: - task
    public var task: Task {
        switch self {
            
            //MARK: - search
        case let .searchAll(gender, searchTerm, searchType,lat,long):
         //print(["gender" : gender, "search_term":searchTerm,"latitude":lat,"longitude":long])
       
    
            return .requestParameters(
             parameters: ["gender" : gender, "search_term":searchTerm, "latitude":lat,"longitude":long], encoding: URLEncoding.queryString)
             
            //MARK: - notification
        case let .getNotifications(page, gender):
            return .requestParameters(
                parameters: ["gender" : gender], encoding: URLEncoding.queryString)
            
        case let .cancelAppointment(id):
            return .requestParameters(
                parameters: ["appointment_id":id], encoding: URLEncoding.queryString)
            
        case let .getAppointmentDetails(appoinntmentID):
            return .requestParameters(
                parameters: ["appointment_id":appoinntmentID], encoding: URLEncoding.queryString)
            
            //MARK: - get appointmment
        case let .getAllAppointmnents(gender):
            return .requestParameters(
                parameters: ["gender":gender], encoding: URLEncoding.queryString)
            
        case let .getAppointMents(date, gender):
            return .requestParameters(
                parameters: ["date":date,"gender":gender], encoding: URLEncoding.queryString)
            
            //MARK: - get history
       
        case let .orderHIstory(gender):
            return .requestParameters(
                parameters: ["gender":gender], encoding: URLEncoding.queryString)
            
            //MARK: - offer list
       
        case let .getOffers(shopId):
            return .requestParameters(
                parameters: ["branch_id":shopId], encoding: URLEncoding.queryString)
            
            //MARK: employee
            
        case let .getEmployees(lat, lon, gender, branchId, EmployeeID, servicesID):
            let param  = getEmployeesParam(lat: lat, lon: lon, gender: gender, branchId:branchId,employeeID: EmployeeID,servicesID: servicesID )
            //print("employee paraam: \(param)")
            return .requestParameters(
                parameters:param, encoding: URLEncoding.queryString)
            
            
            //MARK: services
            
        case let .getCategory(gender, keyValue, key):
            return .requestParameters(
                parameters: getCategoriesParam(gender: gender, keyValue: keyValue, key: key), encoding: URLEncoding.queryString)
            
            
        case let .getservices(shopId, gender, employeeID, categoryID):
            
            let param = getServicesParam(gender: gender, branchId: shopId, employeeID: employeeID, categoryId: categoryID)
            
            return .requestParameters(
                parameters: param, encoding: URLEncoding.queryString)
            
           //MARK: fav
        case let .checkFaourite(shopId, gender):
            return .requestParameters(
                parameters: ["shop_id":shopId, "gender" : gender], encoding: URLEncoding.queryString)
            
            
            //MARK: branches
        case let .mySalons(gender):
            return .requestParameters(
                parameters: ["gender":gender], encoding: URLEncoding.queryString)
            
            
            
        case let .getBranches(gender,lat,lon,customerID):
            let param = getBranchesListParam(gender: gender, lat: lat, lon: lon, customerID: customerID)
            return .requestParameters(
                parameters: param, encoding: URLEncoding.queryString)
            
            
            
            //MARK: profile
        case .uploadProfileImage(let params):
            var formData = [MultipartFormData]()
            for (key, value) in params {
                if let imgData = value as? Data {
                    formData.append(MultipartFormData(provider: .data(imgData), name: key, fileName: "\(randomString(length: 6)).jpg", mimeType: "image/jpeg"))
                } else {
                    formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
                }
            }
            return .uploadMultipart(formData)
            
            //    case .updateProfile(let params):
            //        var formData = [MultipartFormData]()
            //        for (key, value) in params {
            //            if let imgData = value as? Data {
            //                formData.append(MultipartFormData(provider: .data(imgData), name: key, fileName: "testImage.jpg", mimeType: "image/jpeg"))
            //            } else {
            //                formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
            //            }
            //        }
            //        return .uploadMultipart(formData)
            //
            
            // case .cancelAppointment(let key):
            //         return .requestParameters(parameters: ["appointment_id" : key], encoding: URLEncoding.queryString)
            
        default:
            if(parameters != nil){
                return Task.requestParameters(parameters: (parameters)!, encoding: parameterEncoding)
            }else{
                return Task.requestPlain
            }
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case  .login(_):
            return JSONEncoding.prettyPrinted
        default:
            return JSONEncoding.prettyPrinted
        }
    }
}


func getServicesParam(gender:Int,branchId:Int?, employeeID:Int?, categoryId:Int?) ->[String:Any]{
    var param  =  ["gender":gender]
    
    if let branchId {
        param["branch_id"] = branchId
    }
    
    if let employeeID {
        param["employee_id"] = employeeID
    }
    
    
    if let categoryId {
        param["category_id"] = categoryId
    }
    return param
}

func getEmployeesParam(lat:String, lon:String,gender:Int,branchId:Int?, employeeID:Int?, servicesID:Int?) ->[String:Any]{
    
    if branchId == nil,employeeID == nil,servicesID==nil{
        return  [ "latitude": lat , "longitude": lon, "gender":gender]
    }else{
        
        var param  =  ["gender":gender]
        
        if let branchId {
            param["branch_id"] = branchId
        }
        
        if let employeeID {
            param["employee_id"] = employeeID
        }
        
        
        if let servicesID {
            param["service_id"] = servicesID
        }
        return param
    }
}

func getCategoriesParam(gender:Int,keyValue:Int?, key:String)-> [String:Any]{
    
    if keyValue == nil{
        return ["gender":gender]
    }else{
        return [key:keyValue, "gender":gender]
    }
}


func getBranchesListParam(gender:Int?,lat:Double?,lon:Double?,customerID:Int?)->[String:Any]{
    if customerID != nil{
        if lat == nil{
            return  ["gender":gender,"customer_id":customerID]
        }
        return  [ "latitude": lat, "longitude": lon, "gender":gender,"customer_id":customerID]
    }
    else{
        if lat == nil{
            return  ["gender":gender]
        }
        return
        [ "latitude": lat, "longitude": lon, "gender":gender]
    }
}

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}


func stubbedResponse(_ filename: String) -> Data! {
    let bundleURL = Bundle.main.bundleURL
    
    let path = bundleURL.appendingPathComponent("Frameworks/PartyAppKit.framework/\(filename).json") //bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: path))
}


private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}


func mimeType(for data: Data) -> String {
    
    var b: UInt8 = 0
    data.copyBytes(to: &b, count: 1)
    
    switch b {
    case 0xFF:
        return "image/jpeg"
    case 0x89:
        return "image/png"
    case 0x47:
        return "image/gif"
    case 0x4D, 0x49:
        return "image/tiff"
    case 0x25:
        return "application/pdf"
    case 0xD0:
        return "application/vnd"
    case 0x46:
        return "text/plain"
    default:
        return "text/plain"
    }
}


