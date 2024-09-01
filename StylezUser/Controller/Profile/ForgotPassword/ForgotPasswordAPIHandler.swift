//
//  ForgotPasswordAPIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation
import UIKit



//MARK: - handling forgot password api
extension ForgotPasswordViewController{
    
    func moveToOTPView(id:Int, otp:String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.otpView) as! OTPViewController
        vc.otp =  otp
        vc.userId =  id
        vc.mobile = self.txtEmail.text ?? ""
        vc.isPassword = true
        vc.isEmail = self.isEmail
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func forgotPassword2(){
        let emailOrNum = txtEmail.text ?? ""
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: self.isEmail)
        
        let viewModel = ForgotPasswordViewModel()
        viewModel.forgotPassword(request: request) { id, otp, errorMsg in
            
            DispatchQueue.main.async {
             
                loadingIndicator.removeFromSuperview()
                
                if  otp != nil && id != nil{
                
                    self.moveToOTPView(id: id!, otp: otp!)
                }
                else{
                    
                    showAlert(title: "", subTitle:  errorMsg ?? LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") , sender: self)
                }
            }
        }
    }
}
