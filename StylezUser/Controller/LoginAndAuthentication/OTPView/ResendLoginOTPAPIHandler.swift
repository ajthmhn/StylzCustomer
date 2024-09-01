//
//  ResendLoginOTPAPIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation
import UIKit

//MARK: - resenrLoginOTP
extension OTPViewController{
    func resendLoginOtp2(){
        
        let email = self.mobile
        
        let request = VerifyOTPRequest(phone: email, email: email, isEmail: self.isEmail)
        
        let validation = OTPValidation()
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let loadingIndicator = getIndicator(controller: self)
            
            let resource = VerifyOTPResource()
            resource.sendOtpLogin(request: request) {  otp, Msg  in
                
                DispatchQueue.main.async {
                    
                    loadingIndicator.removeFromSuperview()
                    
                    //print("got verify otp response")
                    
                    if otp != nil{
                        self.otp =  "\(otp)"
                        
                        showAlert(title: "", subTitle:   "\(Msg ?? LocalizationSystem.sharedInstance.localizedStringForKey(key:  self.getOTPSentAlertKey() , comment: "")), OTP: \(self.otp)", sender: self)
                        
                        
                    }
                    else{
                      
                        showAlert(title: "", subTitle:  Msg ?? LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") , sender: self)
                    }
                }
            }
        }
        else{
            showAlert(title: "", subTitle: validationResult.errorMessage ?? "" , sender: self)
        }
    }
    
    func getOTPSentAlertKey() -> String{
        if self.isEmail
        {
            return "check_email"
        }
        else{
            return "check_phone"
        }
        
    //OTP sent to your phone number
        
    }
}
