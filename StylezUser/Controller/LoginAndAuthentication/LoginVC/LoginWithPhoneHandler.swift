//
//  LoginWithPhone.swift
//  StylezUser
//
//  Created by MACBOOK on 2/26/24.
//

import Foundation
import UIKit

//MARK: - login with phone
extension LoginViewController{
    
    func loginPhone2(){
        let phone  = self.txtPhone.text ?? ""
        
        let request = VerifyOTPRequest(phone: phone , email: "", isEmail: false)
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let viewModel = verifyOTPViewModel()
        viewModel.sendOtpLogin(request: request) { otp, errorMsg in
            
            
            //print("login with phone: \(request.getRequestBody())")
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if otp != nil{
                    self.moveToVerifyOtp(otp: otp ?? 0, userId: 0,isphoneLogin: true, isEmail: false)
                }
                else{
                    showAlert(title: "", subTitle:  errorMsg ?? LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") , sender: self)
                }
            }
        }
    }
    //
    //    func loginPhone2(){
    //
    //        let request = LoginRequestWithNumber(number: self.txtPhone.text!)
    //
    //        let activityIndicator = self.getIndicator(controller: self)
    //
    //        let viewModel = LoginViewModel()
    //
    //        //print("login with phone: \(request.getLoginRequestBody())")
    //
    //        viewModel.loginPhone(request: request) { result, errorMsg in
    //
    //            DispatchQueue.main.async {
    //
    //                activityIndicator.removeFromSuperview()
    //
    //                if errorMsg == nil{
    //                    self.moveToVerifyOtp(otp: result?.data.otp ?? 0, userId: result?.data.userID ?? 0,isphoneLogin: true, isEmail: false)
    //                }
    //                else{
    //                    showAlert(title: "", subTitle:  errorMsg ?? LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") , sender: self)
    //                }
    //            }
    //        }
    //    }
    
    func moveToVerifyOtp(otp:Int, userId:Int, isphoneLogin:Bool, isEmail:Bool){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.otpView) as! OTPViewController
        
        vc.otp =  "\(otp)"
        vc.userId =  userId
        
        isEmail ?
        (vc.mobile = self.txtEmail.text ?? "") :
        (vc.mobile = self.txtPhone.text ?? "")
        
        vc.isPhoneLogin = isphoneLogin
        vc.isEmail = isEmail
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

