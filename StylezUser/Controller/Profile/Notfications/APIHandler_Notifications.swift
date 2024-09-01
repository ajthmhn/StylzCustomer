//
//  APIHandler_Notifications.swift
//  StylezUser
//
//  Created by MACBOOK on 3/6/24.
//

import Foundation
import UIKit
import StylesWebKit

//MARK: - fetching notifications data
extension NotificationsViewController{
    
    func getData2(){
        
        var loadingIndicator:UIActivityIndicatorView? = nil
      
        if self.page == 1 {
            loadingIndicator = self.getIndicator(controller: self)
            self.notifications.removeAll()
        }
       
        let gender = checkIfNotMale() == true ? 2 : 1
        
        let request = NotificationRequest(page: self.page, gender: gender)
        
        let resource = NotificationReosurce()

        resource.getNotifications(request: request) { notifications in
           
            self.isDataLoading = false
           
            DispatchQueue.main.async {
                
                if loadingIndicator != nil{
                    loadingIndicator?.removeFromSuperview()
                }

                if notifications != nil, let notifications{
                    
                    self.checkIfempty(notifications: notifications)
                    
                    self.notifications.append(contentsOf:  notifications)
                    
                    self.updateView()
                    
                }else{
                  
                    self.dataEmpty = true
                    self.updateView()
                }
            }
        }
    }
    
    func updateView(){
        self.tblNotif.reloadData()
        
        let label = self.getNoDataLabel(tableORColView: self.tblNotif)
        
        if self.notifications.count == 0{
            self.tblNotif.backgroundView = label
        }else{
            self.tblNotif.backgroundView = nil
        }
    }
    
    func checkIfempty(notifications:[NOtifications]){
        if notifications.count == 0{
            self.dataEmpty = true
        }else{
            self.dataEmpty = false
        }
    }
}
