////
////  LoginViewModel.swift
////  StylezUser
////
////  Created by MACBOOK on 2/27/24.
////
//
//import Foundation
//
//struct LoginViewModel{
//    
//    
//    func loginPhone(request: LoginRequestWithNumber, completionHandler:@escaping  (_ result: LoginResponseWithNum?, _ errorMsg: String?)->())
//    {
//        let validation = LoginValidation()
//        let validationResult = validation.validateNumber(request: request)
//        
//        if validationResult.success{
//            // let loadingIndicator = getIndicator(controller: self)
//            let resource = LoginResourceNumber()
//            resource.authenticateUserWithNumber(request: request) { result, errorMsg in
//                //  loadingIndicator.removeFromSuperview()
//                
//                //if errorMsg == nil{
//                //            self.moveToVerifyOtp(otp: result?.data.otp ?? 0, userId: result?.data.userID ?? 0,isphoneLogin: true, isEmail: false)
//                completionHandler(result, errorMsg)
//                //}
//                //  else{
//                //                        showAlert(title: "", subTitle:  errorMsg ?? "Something went wrong..." , sender: self)
//             //   completionHandler(nil, errorMsg)
//                //  }
//                
//            }
//        }
//        else{
//            //   showAlert(title: "", subTitle:  validationResult.errorMessage ?? "" , sender: self)
//            completionHandler(nil, validationResult.errorMessage)
//            
//        }
//    }
//}
