//
//  VerifyOTPHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation
import UIKit

//MARK: - verify otp login
extension OTPViewController{
    
    func getOtp() ->Int
    {
        if otpRight == ""{
            return 0
        }
        
        return Int(otpRight) ?? -1
    }
    
    func verifyLoginOtp2(){
        
        let otp = getOtp()
        
        let request = verifyLoginOTPRequest( otp: otp, id: userId, isEmail: self.isEmail,isUpadting:  isUpdate,numOrEmail: numOrEmail)
       
        //print(request)
        
        let validation = VerifyLoginOTPValidation()
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            let loadingIndicator = getIndicator(controller: self)
        
            let resource = VerifyLoginOTPResource()
            resource.verifyLoginOtp(request: request) { errorMsg in
                
                DispatchQueue.main.async {
            
                    loadingIndicator.removeFromSuperview()
                    
                    if errorMsg != nil{
                        showAlert(title: "", subTitle:  errorMsg ?? LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") , sender: self)
                    }
                    else{
                      //  self.saveDetailsAndmoveToRootView()
                        self.fetchCustomerInfoAndMoveToRoot()
                   }
                }
            }
        }
        else{
            showAlert(title: "", subTitle:  validationResult.errorMessage ?? LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") , sender: self)
        }
    }
}
