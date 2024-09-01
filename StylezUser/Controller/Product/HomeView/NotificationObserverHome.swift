//
//  NotificationObserverHome.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import StylesWebKit
import UIKit

extension HomeViewController{

    func  setNotificationObservers(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginNotif(notification:)), name: Notification.Name("session_reset"), object: nil)
        
        
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) {
        
            //[unowned self] notification in
        
            [weak self] Notification in
            
            if let strongSelf = self {
                //print("notification observer called")
                strongSelf.requateLocation()
            }
        }
    }
    
    @objc func loginNotif(notification: Notification) {
        //print("~~~~~~~~~~~ loginNotif")
        
        deleteUserDetails()
        StylzAPIFacade.shared.resetSession()
        clearCart()
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "root_vc")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: false)
        
        // showAlert(title: "", subTitle: "user logged out", sender: vc!)
    }
  
}
