//
//  LoginWithEmailHanlder.swift
//  StylezUser
//
//  Created by MACBOOK on 2/26/24.
//

import Foundation
import UIKit
import StylesWebKit

//MARK: - login with email
extension LoginViewController{
    
    func loginUser2(){
        
        let request = LoginRequestWithEmail(userEmail: txtEmail.text!, userPassword: txtPassword.text!, deviceToken: self.deviceToken)
      
        //print("login with email: \(request.getLoginRequestBody())")
     
        let loadingIndicator = self.getIndicator(controller: self)
        
        let viewModel = LoginEmailViewModel()
        viewModel.login(request: request) {isVerified, id, errorMsg in
          
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
            
                if  errorMsg != nil{
                    self.handleLoginError(err: errorMsg!, userID: id)
                }
                else{ 
                    K.User.isSubscribed = Bean.sharedIntance.get_BoolValue(key: K.UserDefaultsKeys.isSubscribed)
                    
                    Bean.sharedIntance.set_IntValue(value: id ?? 0, key: K.UserDefaultsKeys.userID)
                    
                    self.fetchCustomerInfoAndMoveToRoot()
                   // self.moveToRootVC()
                }
            }
        }
    }
    
}

//MARK: - fetch user data
extension LoginViewController{
  
    func fetchCustomerInfoAndMoveToRoot(){
            let resource = GetCustomerInformation()
            resource.getCustomerInformation { err in
                if err != nil{
                    showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""), sender: self)
                }
                else{
                    self.moveToRootVC()
                    }
            }
        }
}

extension LoginViewController{
    
    func moveToRootVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "root_vc")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
   
    func handleLoginError(err:String, userID:Int?){
        if err == LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.verifyYourEmaiil, comment: ""), let id = userID{
            showVerifyYourEmailAlert(err: err, userID: id)}
        else{
            showAlert(title: "", subTitle:  err , sender: self)
        }
    }
    
    // callig send otp api
    func showVerifyYourEmailAlert(err:String, userID:Int){
        let alertController = UIAlertController(title: "", message: err, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "ok", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            self.sendOtpLogin(phone: "", email: self.txtEmail.text ?? "", id: userID, isEmail: true)
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
