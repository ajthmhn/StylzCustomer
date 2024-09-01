//
//  APIHandler_services.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import UIKit

//MARK: - add to cart
extension ServiceDetailsViewController
{
    // same service id won't be added into the cart
        func addToCart(){
               if selectedService == nil{
                   if selectedBarber == -1{
                       showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_service", comment: ""), sender: self)
                       return
                   }
       
                   var details = [String:Any]()
                   details["customer_id"] = self.selectedEmployee?.id
                   details["customer_image"] = self.selectedEmployee?.image
                   details["customer_name"] =  self.selectedEmployee?.first_name
                   details["service_id"] = self.selectedEmployee?.services[selectedBarber].id
                   details["service_name_en"] = self.selectedEmployee?.services[selectedBarber].name_en
                   details["service_name_ar"] = self.selectedEmployee?.services[selectedBarber].name_ar
                   details["price"] = self.selectedEmployee?.services[selectedBarber].amount
                   if parents != nil{
                       //print("parent is not equaals to nil , branchId: \(self.branchID), parent.salon.id \(self.parents?.salon?.id)")
                 //   details["shop_id"] = self.parents?.salon?.id //~
                       details["shop_id"] = self.branchID //~
                   
                   }else{
                       //print("parent is equals to nil")
                       //         details["shop_id"] = self.selectedEmployee?.branchId //~
                       details["shop_id"] = self.branchID //~
            
                   }
                  
                   
                   //print("~ Cart details: \(details), shop id : \(details["shop_id"])")
                   saveCart(details: details)
       
               }else{
                   if selectedBarber == -1{
                       showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_employee", comment: ""), sender: self)
                       return
                   }
       
                   var details = [String:Any]()
                
                   details["customer_id"] = self.employeeArraay[self.selectedBarber].id
                 
                   details["customer_image"] = self.employeeArraay[self.selectedBarber].image
                 
                   details["customer_name"] =  self.employeeArraay[self.selectedBarber].first_name
                   
                   details["service_id"] = self.selectedService?.id
                   details["service_name_en"] = self.selectedService?.name_en
                   details["service_name_ar"] = self.selectedService?.name_ar
                   details["price"] = self.selectedService?.amount
               
                 //  details["shop_id"] = self.parents?.salon?.id //~
       
                   details["shop_id"] = self.branchID //~
       
                   //print("~ Cart details: \(details), shop id : \(details["shop_id"])")
                   saveCart(details: details)
               }
       
               if parents != nil{
                   showSuccess(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "service_added", comment: ""), view: (parents?.view)!)
                   parents?.viewCart.isHidden = false
                   parents?.lblCount.text = "\(getCartData()?.count ?? 0)"
       
       
                   var totals = [Double]()
                   
                   if let cartData = getCartData(){
                       for all in cartData{
                           totals.append(Double(all["price"] as? String ?? "0.0")!)
                       }
                   }
       
                   let sum = totals.reduce(0, +)
                   let vat = (15 * sum) / 100
       
                   let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
                   let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
                   let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "basket", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
                   let attributedString4 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(sum)", attributes:attrs4 as [NSAttributedString.Key : Any])
                   attributedString3.append(attributedString4)
                   parents?.lblPrice.attributedText = attributedString3
       
                   animationScaleEffectSingle(view: (parents?.viewCart)!)
               }else{
                   showSuccess(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "service_added", comment: ""), view: (searchView?.view)!)
                   searchView?.viewCart.isHidden = false
                   searchView?.lblCount.text = "\(getCartData()?.count ?? 0)"
       
       
                   var totals = [Double]()
                   if let cartData = getCartData(){
                       for all in cartData{
                           totals.append(Double(all["price"] as? String ?? "0.0")!)
                       }
                   }
                   
                   let sum = totals.reduce(0, +)
                   let vat = (15 * sum) / 100
       
                   let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
                   let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
                   let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "basket", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
                   let attributedString4 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(sum)", attributes:attrs4 as [NSAttributedString.Key : Any])
                   attributedString3.append(attributedString4)
                   searchView?.lblPrice.attributedText = attributedString3
       
                   animationScaleEffectSingle(view: (searchView?.viewCart)!)
       
               }
       
               self.dismiss(animated: true)
           }
    
    
}
