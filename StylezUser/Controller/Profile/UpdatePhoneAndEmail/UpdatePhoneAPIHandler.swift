//
//  UpdatePhoneAPIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 3/3/24.
//

import Foundation
import StylesWebKit

//MARK: - updating phone
extension UpdatePhoneViewController{
    
    func updatePhone2(){
        let loadingIndicator = self.getIndicator(controller: self)
        
        let number  = txtPhone.text ?? ""
      
        
        //let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateNumberRequest(number: number)
        
        let viewModel = updateNumberViewModel()
        viewModel.updatePhone(request: request) { otp, userID, errorMsg in
            
            DispatchQueue.main.async {
            
                loadingIndicator.removeFromSuperview()
                
                if errorMsg == nil{
                    self.moveToOTPView(otp: otp!, id: userID!, isUpdate: true, isEmail: false)  }
                else{
                    showAlert(title: "", subTitle:  errorMsg! , sender: self)
                }
            }
        }
    }
}

