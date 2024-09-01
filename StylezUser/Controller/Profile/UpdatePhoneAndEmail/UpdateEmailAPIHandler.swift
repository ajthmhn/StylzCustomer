//
//  UpdateEmailAPIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 3/3/24.
//

import Foundation
import StylesWebKit

//MARK: - updating email
extension UpdatePhoneViewController{
    
    func moveToOTPView(otp:String, id:Int, isUpdate:Bool, isEmail:Bool){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.otpView) as! OTPViewController
        vc.otp =  otp
        vc.userId =  id
        vc.isEmail = isEmail
        vc.isUpdate = isUpdate
        vc.numOrEmail = txtPhone.text ?? ""
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func updateEmail2(){
        let loadingIndicator = self.getIndicator(controller: self)
        
        let email  = txtPhone.text ?? ""
        //let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateEmailRequest( email: email)
        
        let viewModel = UpdateEmailViewModel()
        viewModel.updateEmail(request: request) { otp, userID, errorMsg in
         
            DispatchQueue.main.async {
            
                loadingIndicator.removeFromSuperview()
                
                if errorMsg == nil{
                    self.moveToOTPView(otp: otp!, id: userID!, isUpdate: true, isEmail: true)  }
                else{
                    showAlert(title: "", subTitle:  errorMsg! , sender: self)
                }
            }
        }
    }
}


