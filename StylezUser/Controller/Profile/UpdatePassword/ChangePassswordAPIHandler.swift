//
//  ChangePassswordAPIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/28/24.
//

import Foundation


//MARK: - change password
extension UpdatePasswordViewController
{
    
    func showMsgAndPopBack(){
        
        showSuccess(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "password_updated", comment: ""), view: self.view)
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func changePassword2(){
        let oldPass = self.txtOldPass.text ?? ""
        let newPass = self.txtPassword.text ?? ""
        let confirmPass = self.txtConfirm.text ?? ""
       
        let request = ChangePasswordRequest(password: newPass, confirmPass: confirmPass, oldPassword: oldPass)
        
        let activityIndicator = self.getIndicator(controller: self)
      
        let viewModel = ChangePassViewModel()
        viewModel.changePassword(request: request) { errorMsg in
          
            DispatchQueue.main.async {
                activityIndicator.removeFromSuperview()
                if errorMsg != nil{
                    showAlert(title: "", subTitle:  errorMsg! , sender: self)
                }
                else{
                    self.showMsgAndPopBack()
                }
            }
        }
    }
}

