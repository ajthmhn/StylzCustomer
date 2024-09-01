//
//  ForgotPassAPIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation

//MARK: - forgot password
extension OTPViewController{
    
    func forgotPassword2(){
        
        let request = ForgotpasswordRequest(phone: self.mobile, isEmail: self.isEmail)
      
        let validation = ForgotPasswordValidation()
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
        
            let loadingIndicator = getIndicator(controller: self)
            
            let resource = ForgotPasswordResource()
            resource.forgotPassword(request: request){id, otp, Msg in
            
                DispatchQueue.main.async {
                
                    loadingIndicator.removeFromSuperview()
                    
                    //print("got verify otp response otp: \(otp)")
                    
                    if  otp != nil{
                        self.otp =  otp ?? ""
                        
                        showAlert(title: "", subTitle: Msg ??  LocalizationSystem.sharedInstance.localizedStringForKey(key: self.getOTPSentAlertKey(), comment: "") , sender: self)
                    }
                    else{
                        showAlert(title: "", subTitle:  Msg ?? LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") , sender: self)
                    }
                }
            }
        }
        else{
            showAlert(title: "", subTitle: validationResult.errorMessage ?? LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") , sender: self)}
    }
}

