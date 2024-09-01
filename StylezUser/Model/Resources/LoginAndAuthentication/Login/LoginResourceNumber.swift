////
////  LoginResourceNumber.swift
////  StylezUser
////
////  Created by MACBOOK on 2/21/24.
////
//
//import Foundation
//import StylesWebKit
//
//struct LoginResourceNumber{
//    
//    func authenticateUserWithNumber(request: LoginRequestWithNumber, completionHandler:@escaping (_ result: LoginResponseWithNum?, _ errorMsg: String?)->()) {
//        
//        //loginPhone
//        StylzAPIFacade.shared.loginPhone(profDet: request.getLoginRequestBody()) { (aRes) in
//            //print(aRes?.json)
//            if aRes?.statusCode == 200{
//                if aRes?.json?["status"].stringValue == "true"{
//                    let decoder = JSONDecoder()
//                    do {
//                        let decodedData = try decoder.decode(LoginResponseWithNum.self, from: (aRes?.data)!)
//                        completionHandler(decodedData, nil)
//                    }
//                    catch let error{
//                        debugprint("error occured while decoding = \(error.localizedDescription)")
//                        completionHandler(nil, error.localizedDescription)
//                    }
//                }
//                else{
//                    if let error = aRes?.json?["error"].array{
//                        if error.count > 0{
//                            completionHandler(nil, error[0].stringValue)
//                        }else{
//                            completionHandler(nil, aRes?.json?["error"].stringValue ?? "")
//                        }
//                    }
//                    else if let error = aRes?.json?["error"].dictionary{
//                        var err =  "Something went wrong"
//                        err = error["phone"]?.stringValue ?? ""
//                        completionHandler(nil, err)
//                    }
//                    else{
//                        let eror = aRes?.json?["error"].stringValue
//                        if eror?.range(of:"verify your email address") != nil {
//                            completionHandler(nil, "verify your email address")
//                        }
//                        else{
//                            completionHandler(nil, aRes?.json?["error"].stringValue ?? "")
//                        }
//                    }
//                }
//            }
//            else{
//                if let error = aRes?.json?["error"].array{
//                    if error.count > 0{
//                        completionHandler(nil, error[0].stringValue)
//                    }else{
//                        completionHandler(nil, aRes?.json?["error"].stringValue ?? "")
//                    }
//                }else{
//                    completionHandler(nil, aRes?.json?["error"].stringValue ?? "")
//                }
//            }
//        }
//    }
//    
//}
//    
