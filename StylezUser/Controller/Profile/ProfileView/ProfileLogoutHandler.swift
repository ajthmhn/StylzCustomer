//
//  ProfileLogoutHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 3/3/24.
//

import Foundation
import UIKit
import StylesWebKit

//MARK: - logout
extension ProfileViewController{
   
    func moveToLoginView(){
        let stry = UIStoryboard(name: "Main", bundle: nil)
        let vc = stry.instantiateViewController(withIdentifier:  stryBrdId.login) as! LoginViewController
        vc.isFromProfile = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToRootVc(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "root_vc")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    func callLogoutAPIAndDeleteUserDetails(){
   
        StylzAPIFacade.shared.logout() { ares in
            //print("~logged: \(ares?.json)")
            
            if ares?.statusCode == 200{
            //print("~logged out successfuly: \(ares)")
            }
        }
        
        clearCart()
        Bean.sharedIntance.set_boolValue(value: false, key: K.UserDefaultsKeys.isSubscribed)
        
        deleteUserDetails()
        StylzAPIFacade.shared.resetSession()
    }
    
    func hanldeLogOut(){
        if getUserDetails() == nil{
          moveToLoginView()
        }
        else{
            showLogOutConfirmationAlert()
            
        }
    }
    
    func showLogOutConfirmationAlert(){
       let title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "sign_out", comment: "")
       
        let logOutMsg = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.wantToLogOut, comment: "")
        
        let cancel =  LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.cancelPremium, comment: "")
        
        let alertController = UIAlertController(title:title , message: logOutMsg, preferredStyle: .alert)
          
        let okAction = UIAlertAction(title: title, style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.callLogoutAPIAndDeleteUserDetails()
            DispatchQueue.main.async {
                self.moveToRootVc()
            }
        }
        
        let cancelAction = UIAlertAction(title: cancel, style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}
