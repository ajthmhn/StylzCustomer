//
//  UpdatePassword.swift
//  StylezUser
//
//  Created by MACBOOK on 2/28/24.
//

import Foundation
import UIKit

//MARK: - updatePassword
extension UpdatePasswordViewController{
    
    func updatePassword2(){
        
        let request = UpdatePasswordRequest(otp: self.otp, userID: self.userID, password: self.txtPassword.text ?? "", retypedPass: self.txtConfirm.text ?? "")
        
        let activityIndicator = self.getIndicator(controller: self)
        
        let viewModel = UpdatePassViewModel()
        viewModel.updatePassword(request: request) { errorMsg in
            
            DispatchQueue.main.async {
                
                activityIndicator.removeFromSuperview()
                
                if errorMsg != nil{
                    showAlert(title: "", subTitle:  errorMsg! , sender: self)
                }
                else{
                    showSuccess(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "password_updated", comment: ""), view: self.view)
                    
                    self.moveToLogin(delay: 1)
                }
            }
        }
    }
}

