//
//  VerifyOTPAPIHandler_editProfile.swift
//  StylezUser
//
//  Created by abcd on 25/03/2024.
//

import Foundation

//MARK: - verifyOtp

extension EditProfileViewController{
    
    func moveToOTPView(otp:String, id:Int, isUpdate:Bool, isEmail:Bool){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.otpView) as! OTPViewController
        vc.otp =  otp
        vc.userId =  id
        vc.isEmail = isEmail
        vc.isUpdate = isUpdate
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func sendOtpLogin(phone : String,email:String, id: Int, isEmail:Bool){
        let request = VerifyOTPRequest(phone: phone, email: email, isEmail: isEmail)
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let viewModel = verifyOTPViewModel()
        viewModel.sendOtpLogin(request: request) { otp, errorMsg in
            
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if  otp != nil{
                    self.moveToOTPView(otp: "\(otp!)", id: id, isUpdate: true, isEmail: isEmail)
                }
                else{
                    showAlert(title: "", subTitle:  errorMsg ?? LocalizationSystem.sharedInstance.localizedStringForKey(key:K.Error.someThingWentWrong , comment: "") , sender: self)
                }
            }
        }
    }
}

