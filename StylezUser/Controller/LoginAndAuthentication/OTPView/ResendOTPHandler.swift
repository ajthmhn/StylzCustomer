////
////  ResendOTPHandler.swift
////  StylezUser
////
////  Created by MACBOOK on 2/27/24.
////
//
//import Foundation
////MARK: - resend otp
//extension OTPViewController{
//    
//    func resendOtp2(){
//        let phone = self.mobile
//        //print("phone: \(self.mobile)")
//        
//        let request = LoginRequestWithNumber(number: phone)
//       
//        let validation = LoginValidation()
//        let validationResult = validation.validateNumber(request: request)
//        
//        if validationResult.success{
//            
//            let loadingIndicator = getIndicator(controller: self)
//        
//            let resource = LoginResourceNumber()
//            resource.authenticateUserWithNumber(request: request) { result, errorMsg in
//            
//                DispatchQueue.main.async {
//                
//                    loadingIndicator.removeFromSuperview()
//                    
//                    if errorMsg != nil{
//                        showAlert(title: "", subTitle:  errorMsg ?? LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") , sender: self)
//                    }
//                    else{
//                        self.otp = "\(result?.data.otp ?? 0)"
//                    
//                        showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "check_phone", comment: "") , sender: self)
//                      }
//                }
//            }
//        }
//        else{
//            showAlert(title: "", subTitle:  validationResult.errorMessage ?? "" , sender: self)
//        }
//    }
//}
