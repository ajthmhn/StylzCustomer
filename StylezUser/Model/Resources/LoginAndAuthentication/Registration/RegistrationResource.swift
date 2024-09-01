//
//  RegistrationResource.swift
//  StylezUser
//
//  Created by MACBOOK on 2/21/24.
//

import Foundation
import StylesWebKit
struct RegistrationResource{
    
    func registerUser(request: RegisterRequest, completionHandler:@escaping (_ result: RegistrationResponse?, _ errorMsg: String?)->()) {
        
        //print("request body \(request.getRequestBody())")
        StylzAPIFacade.shared.signUp(profDet: request.getRequestBody()) { (aRes) in
            
            //print(aRes?.json)
            //print(aRes?.statusCode)
           
            if aRes?.statusCode == 201{
                
                if aRes?.json?["status"].int == 201{
                    
                    //api rsponse
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(RegistrationResponse.self, from: (aRes?.data)!)
                        
                     //   //print("data decoded \(decodedData)")
                        
                        completionHandler(decodedData, nil)
                    }
                    catch let error{
                        debugPrint("error occured while decoding = \(error.localizedDescription)")
                        completionHandler(nil,
                                          LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") )
                    }
                }
                else{
                    //   showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
                    if let err = aRes?.json?["message"].stringValue, err != ""  {
                        completionHandler(nil,err)
                    }
                    else{
                        completionHandler(nil,
                                          LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                    }
                }
            }
            else{
                    if let err = aRes?.json?["message"].stringValue, err != ""  {
                        completionHandler(nil,err)
                    }
                    else{
                        //print("this block will be executed")
                        completionHandler(nil, LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                    }
                }
            }
    }
}
