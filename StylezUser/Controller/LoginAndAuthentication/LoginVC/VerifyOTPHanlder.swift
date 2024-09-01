//
//  VerifyOTP.swift
//  StylezUser
//
//  Created by MACBOOK on 2/26/24.
//

import Foundation
import UIKit

//MARK: - verifyOtp
extension LoginViewController{
    
    func sendOtpLogin(phone : String,email:String, id: Int, isEmail:Bool){
        let request = VerifyOTPRequest(phone: phone, email: email, isEmail: isEmail)
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let viewModel = verifyOTPViewModel()
        viewModel.sendOtpLogin(request: request) { otp, errorMsg in
            
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if  otp != nil{
                    isEmail ? self.moveToVerifyOtp(otp: otp! , userId: id, isphoneLogin: false, isEmail: true)
                    : self.moveToVerifyOtp(otp: otp! , userId: id, isphoneLogin: true, isEmail: false)
                }
                else{
                    showAlert(title: "", subTitle:  errorMsg ?? LocalizationSystem.sharedInstance.localizedStringForKey(key:K.Error.someThingWentWrong , comment: "") , sender: self)
                }
            }
        }
    }
}


