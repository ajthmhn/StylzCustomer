//
//  UIHandler_SummaryView.swift
//  StylezUser
//
//  Created by abcd on 30/05/2024.
//

import Foundation
import UIKit

extension SummeryViewController{
    
    func setThemeColor(){
        btnCheckout.backgroundColor = getThemeColor()
        btnBack.tintColor = getThemeColor()
        btnApply.tintColor = getThemeColor()
        
    }
    
    func localizeView(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "payment", comment: "")
        lblSubHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "sub_total", comment: "")
        lblTotalHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "order_total", comment: "")
        lblDiscountTitle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "discount", comment: "")
        txtPromo.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_promo", comment: "")
        btnApply.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "apply", comment: ""), for: .normal)
        lblSelectCard.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_card", comment: "")
        btnNewCard.setTitle( LocalizationSystem.sharedInstance.localizedStringForKey(key: "use_new_card", comment: ""), for: .normal)
        lblSummary.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "summary", comment: "")
        btnsubmit.setTitle( LocalizationSystem.sharedInstance.localizedStringForKey(key: "one", comment: ""), for: .normal)
        btnApple.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "pay_apple", comment: ""), for: .normal)
        btnCard.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "pay_card", comment: ""), for: .normal)
        lblSelectPayment.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "seelct_payment", comment: "")
        lblVatHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "vat", comment: "")
        
        self.lblDiscount.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) 0.0"
        
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            txtPromo.textAlignment = .right
        }else{
            txtPromo.textAlignment = .left
        }
        
        viewCards.isHidden = true
        
        viewSummary.clipsToBounds = true
        viewSummary.layer.cornerRadius = 20
        viewSummary.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        discountApplied = 1
       
        imgTypes[1].image = UIImage(named: checkIfNotMale() == true ? "circle_sel_girl" : "circle_sel_boy")
        imgTypes[0].image = UIImage(named: "circle_unsel")
        
        
        lblSelectOptions.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_options", comment: "")
        lblBook.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "book_appoint", comment: "")
        
        lblBook15.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "book_15", comment: "")) \(K.User.dicountValue)% \(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.discount, comment: ""))"
        
    }
}

//MARK: - set initial view
extension SummeryViewController{
    
    
    func setInitialView(){
        
        if isReorde == true{
            var totals = [Double]()
            for all in appointments?.services ?? []{
                totals.append(Double(all.service_amount ?? "0.0")!)
            }
            
            let total = totals.reduce(0, +)
            let discount = (15 * total) / 100
            
            let sum = total -  discount
            
            let vat = (15 * sum) / 100
            
            let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "place_order", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
            //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
            let attributedString4 = NSMutableAttributedString(string:"\(sum)", attributes:attrs4 as [NSAttributedString.Key : Any])
            attributedString3.append(attributedString4)
            lblCheckout.attributedText = attributedString3
            
            lblSub.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: sum - vat) )"
            lblTotal.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: sum))"
            lblVat.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: vat))"
            
            lblPaidTotal.textColor = getThemeColor()
            lblPrepaidTotal.textColor = getThemeColor()
            lblPrepaidTotal.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: total))"
            lblPaidTotal.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: sum))"
            
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(total)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            
            lblPaidDiscount.attributedText = attributeString
            
        }else{
            var totals = [Double]()
           
            if let cartData = getCartData(){
                for all in cartData{
                    totals.append(Double(all["price"] as? String ?? "0.0")!)
                }
            }
            
            let total = totals.reduce(0, +)
            
            //MARK: using global dynamic value for  discount
         //   let discount = (15 * total) / 100
          
            let discount = (K.User.dicountValue * total) / 100
            payNowDiscountedAmount = discount
            let sum = total -  discount
            
            let vat = (15 * sum) / 100
            
            let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "place_order", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
            //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
            let attributedString4 = NSMutableAttributedString(string:"\(sum) \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: ""))", attributes:attrs4 as [NSAttributedString.Key : Any])
            attributedString3.append(attributedString4)
           
            lblCheckout.attributedText = attributedString3
            
            lblSub.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: sum - vat) )"
            lblTotal.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: sum))"
            lblVat.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: vat))"
            
            lblPaidTotal.textColor = getThemeColor()
            lblPrepaidTotal.textColor = getThemeColor()
            lblPrepaidTotal.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: total))"
            lblPaidTotal.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: sum))"
            
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(total)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            
            lblPaidDiscount.attributedText = attributeString
            
        }
      
    }
}
