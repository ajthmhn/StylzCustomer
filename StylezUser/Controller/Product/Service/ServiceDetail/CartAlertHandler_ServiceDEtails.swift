//
//  CartHandler_Service.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import UIKit
extension ServiceDetailsViewController{
    
    
  func handleCartAlertAndSaveCartData(){
        
        if getCartData()?.count ?? 0 >  0{
            let shopId =  getCartData()?[0]["shop_id"] as? Int
            //print("shop id: \(shopId), ")
            
            if self.parents == nil{
                // from search view
            
                //print("shop id: \(shopId),self.selectedEmployee?.branchId \(self.selectedEmployee?.branchId), branchID:  \(self.branchID)")
                
             //   if self.selectedEmployee?.branchId != shopId{
                if self.branchID != shopId{
               
                    let alertController = UIAlertController(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "cart_contains", comment: ""), message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "do_continue", comment: ""), preferredStyle: .alert)
                 
                    let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "yes", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        clearCart()
                        self.addToCart()
                    }
                   
                    let cancelAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "no", comment: ""), style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
            }else{
              
                //print("shop id: \(shopId), self.parents?.salon?.id: \(self.parents?.salon?.id), \(self.branchID)")
              
              //  if self.parents?.salon?.id != shopId{
                if self.branchID != shopId{
                 
                    //from service view
                  
                    let alertController = UIAlertController(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "cart_contains", comment: ""), message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "do_continue", comment: ""), preferredStyle: .alert)

                    let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "yes", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        clearCart()
                        self.addToCart()
                    }
                   
                    let cancelAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "no", comment: ""), style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                   
                    return
                }
            }
        }
        
        addToCart()
     
    }
}
