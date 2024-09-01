//
//  VerifyOTPAPIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation
import UIKit
import StylesWebKit

//MARK: - verify otp
extension OTPViewController{
    
    func saveDetailsAndmoveToRootView(){
        
        // we are not getting user details in verify otp
        saveUserDetails(userDetails: (StylzAPIFacade.shared.session?.currentUser)!)
        
        K.User.isSubscribed = Bean.sharedIntance.get_BoolValue(key: K.UserDefaultsKeys.isSubscribed)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "root_vc")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    func verifyOtp2(){
        
        //print("verifyng phone otp")
        
        let otp = getOtp()
        let phone = self.mobile
        
        let request = VerifyOTPForPhoneRequest(otp: otp, phone: phone, deviceToken: self.deviceToken)
        
        //print(request)
       
        let validation = OTPForPhoneValidation()
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let loadingIndicator = getIndicator(controller: self)
            
            let resource = VerifyOTPForPhoneResource()
            resource.verifyOTP(request: request) { errorMsg  in
                
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
            showAlert(title: "", subTitle:  validationResult.errorMessage ?? LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") , sender: self)}}
}



//MARK: - fetch user
extension OTPViewController{
    
    
    func fetchCustomerInfoAndMoveToRoot(){
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let resource = GetCustomerInformation()
        resource.getCustomerInformation { err in
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if err != nil{
                    showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""), sender: self)
                }
                else{
                    //print("~ fethced user info ")
                    self.saveDetailsAndmoveToRootView()
                }
            }
        }
    }
}
