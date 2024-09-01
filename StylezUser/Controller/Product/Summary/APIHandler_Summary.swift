//
//  APIHandler_Summary.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import UIKit
import StylesWebKit


//MARK: - get card
extension SummeryViewController{
    
    func getCard(){
        let loadingIndicator = UIActivityIndicatorView(frame: self.view.bounds)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating();
        
        self.view.addSubview(loadingIndicator)
        self.cards.removeAll()
        
        
        //  appointments.removeAll()
        
        StylzAPIFacade.shared.getCard{ (aRes) in
            
            
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
            }
            
            //print("~ card data: \(aRes?.json)")
            
            if aRes?.statusCode == 200{
                
                if let data = aRes?.json?["data"].array{
                    
                    for m in data{
                        let booking = Cards(json: m)
                        self.cards.append(booking)
                    }
                    
                }
                
                DispatchQueue.main.async {
                    self.tblCards.reloadData()
                }
                
            }
        }
    }
}



//MARK: - apply  promo
extension SummeryViewController{
    
    func applyPromo(){
        
        let loadingIndicator = getIndicator(controller: self)
        
        var details = [String:Any]()
        var appointment = [[String:Any]]()
        
        if isReorde == true{
            var appointment = [[String:Any]]()
            
            for all in appointments?.services ?? []{
                var data = [String:Any]()
                data["service_id"] = all.service_id
                data["employee_id"] = all.employee_id
                appointment.append(data)
            }
            
            details["date"] = date
            details["start_time"] = time
            details["appointment_details"] = appointment
            details["branch_id"] = appointments?.salon_id ?? 0
            details["discount_coupon"] = self.txtPromo.text ?? ""
        }
        
        else{
            var branchId = 0
            
            if let cartData = getCartData(){
                for all in cartData{
                    var data = [String:Any]()
                    data["service_id"] = all["service_id"] as? Int
                    data["employee_id"] = all["customer_id"] as? Int
                    branchId = all["shop_id"] as? Int ?? 0
                    appointment.append(data)
                }
            }
            
            details["date"] = date
            details["start_time"] = time
            details["appointment_details"] = appointment
            details["branch_id"] = branchId
            details["discount_coupon"] = self.txtPromo.text ?? ""
        }
        
        //print(details)
        
        txtPromo.text = ""
        
        
        StylzAPIFacade.shared.applyPrmo(profDet: details) { [self] (aRes) in
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
            }
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    if let data = aRes?.json?["discount_details"].dictionary{
                        
                        discountValue =  data["discount_value"]?.doubleValue ?? 0.0
                        
                        if discountValue != 0.0{
                            let total = Double((lblTotal.text?.replacingOccurrences(of: "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) ", with: ""))!)
                            
                            //let vat = (discountValue * total!) / 100
                            
                            let vat = data["discounted_amount"]?.doubleValue ?? 0.0
                            
                            self.lblDiscount.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(vat)"
                            
                            let totals = total! - vat
                            
                            self.lblTotal.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: totals))"
                            
                            self.promoApplied = true
                            
                            discountObj = Discount(json: aRes?.json?["discount_details"])
                            
                            showAlert(title: "", subTitle: aRes?.json?["message"].stringValue ?? "" , sender: self)
                        }else{
                            showAlert(title: "", subTitle: aRes?.json?["message"].stringValue ?? "" , sender: self)
                            
                        }
                    }
                }else{
                    showAlert(title: "", subTitle: getErrMsg(json: aRes?.json), sender: self)
                }
            }else{
                showAlert(title: "", subTitle: getErrMsg(json: aRes?.json), sender: self)
                
            }
        }
    }
}

//MARK: - place order
extension SummeryViewController{
    
    func moveToThanKsViewController(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier:  stryBrdId.thanks) as! ThanksViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func placeOrder(paymentID : String , transactionId : String){
        
        let loadingIndicator = getIndicator(controller: self)
        
        let requst = PlaceOrderRequest(referenceId: self.referanceId
                                       , payment_id: paymentID
                                       , transaction_id: transactionId)
        
        //print("place order request: \(requst.getRequestBody()) ")
        let resource = PlaceOrderResource()
        resource.placeOrder(request: requst) { errorMsg in
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if errorMsg != nil{
                    showAlert(title: "", subTitle: errorMsg!, sender: self)
                }
                else{
                    self.moveToThanKsViewController()
                }
            }
        }
    }
}

//MARK: - create card
extension SummeryViewController{
    
    func createCard(cardToken : String , cardNumber : String, cardBrand : String){
        var details = [String:Any]()
        details["card_token"] = cardToken
        details["card_number"] = cardNumber
        details["card_brand"] = cardBrand
        
        StylzAPIFacade.shared.createCard(profDet: details) { (aRes) in
            
            if aRes?.statusCode == 200{
                
            }
        }
    }
    
}


//MARK: - lock time slot
extension SummeryViewController{
    
    func lockTimeSlote(){
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let request = getCreateAppointmentRequest()
        
        //print("~ //print appoinntment request: \(request.getRequestBody())")
        
        let resource = CreateAppointmentResource()
        
        resource.lockTimeSlote(request: request) { appointmentId,referenceID, errorMsg in
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if errorMsg != nil{
                    showAlert(title: "", subTitle: errorMsg!, sender: self)
                }
                else{
                    self.referanceId = referenceID ?? ""
                    //print("referece id: \(self.referanceId)")
                    self.doPlaceOrderOREnablePaymenntView()
                }
            }
        }
    }
    
    
    func doPlaceOrderOREnablePaymenntView(){
        if self.discountApplied == 0{
            self.placeOrder(paymentID: "", transactionId: "")
        }else{
            
            self.viewPayment.isHidden = false
            animationScaleEffectSingle(view: self.btnApple)
            animationScaleEffectSingle(view: self.btnCard)
            animationScaleEffectSingle(view: self.lblSelectCard)
        }
    }
    
    func getCreateAppointmentRequest() -> CreateAppointmentRequest{
        
        setDiscountString()
       
        let date = date
        let time = time
        let customerID = getCustomerID() ?? 0
        let amount = lblTotal.text?.replacingOccurrences(of: "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) ", with: "") ?? ""
        
        
        if isReorde == true{
            let services =  appointments?.services ?? []
            let branchID = appointments?.salon_id ?? 0
            
            return CreateAppointmentRequest(customerID: customerID, branchID: branchID, totalAmount: amount, date: date, Starttime: time, services: services, isReorder: isReorde, discountObj: self.discountObj, disocuntSource: self.discount_source, isDicountAdded: promoApplied, discountedAmount: getDiscountedAmount())
        }
        else{
            return CreateAppointmentRequest(customerID: customerID, branchID: 0, totalAmount: amount, date: date, Starttime: time, services: nil, isReorder: isReorde, discountObj: self.discountObj, disocuntSource: self.discount_source, isDicountAdded: promoApplied, discountedAmount: getDiscountedAmount())
        }
        
    }
    
}

extension SummeryViewController{
    
    func setDiscountString(){
        self.discount_source = ""
        
        if promoApplied{
            appendDiscoutSourceString(discountType: VCConst.Disocunt)
        }
        if discountApplied != 0{
            appendDiscoutSourceString(discountType: VCConst.Paynow)
        }
    }
    
    func appendDiscoutSourceString(discountType:String){
        if discount_source == ""{
            discount_source = discountType
        }
        else{
            discount_source = "\(discount_source),\(discountType)"
        }
    }
    
    func getDiscountedAmount()->Double{
        if let discountObj{
            if discountApplied != 0 {
                
                let  discountedAmount = payNowDiscountedAmount + (discountObj.discountedAmount ?? 0.0)
                
                return discountedAmount
            }
            else
            {
                return discountObj.discountedAmount ?? 0.0
            }
        }
        else{
            return payNowDiscountedAmount
        }
    }
    
}
