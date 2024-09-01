//
//  RegisterAPIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation
import UIKit


//MARK: - handling user registration api
extension RegisterViewController{
    
    func registerUser2(){
     
        let password = txtPassword.text ?? ""
        let email = txtEmail.text ?? ""
        let firstName = txtName.text ?? ""
        let phone =  txtPhone.text ?? ""
        let gender = getGenderCode()
        let fcmmID = deviceToken
        let age = txtAge.text ?? "0"
        
        let request = RegisterRequest(phone: phone, email: email, password: password, firstName: firstName, occupation: "", countryID: countryId, age: Int(age) ?? 0, ispolicyAccepted: isAccept, gender: gender, fcm_id: fcmmID ) // id
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let viewModel = RegistrationViewModel()
        
        //print("request : \(request.getRequestBody())")
        
        viewModel.registerUser(request: request) { result, errorMsg in
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                if errorMsg != nil{
                    showAlert(title: "", subTitle:  errorMsg! , sender: self)
                }
                else{
                    self.moveToOTPView(otp:"\(result?.phoneOtp ?? 0)", id: result?.userID ?? 0)}
            }
        }
    }
    
    func moveToOTPView(otp:String, id:Int){
       //print("otp: \(otp), id  \(id)")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.otpView) as! OTPViewController
        vc.otp =  otp
        vc.userId =  id
        vc.mobile = self.txtPhone.text ?? ""
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}



