//
//  SummeryViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 13/09/23.
//

import UIKit
import Urway
import StylesWebKit
import PassKit

class SummeryViewController: BaseViewController {
  
    struct VCConst {
        static let cellId = "cart_cell_id"
        static let cardCellId = "cards_cell_id"
        static let Disocunt = "Discount"
        static let Paynow = "PayNow"
    }
   
    
    @IBOutlet weak var btnCheckout: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet var lblSub : UILabel!
    @IBOutlet var lblVat : UILabel!
    @IBOutlet var lblTotal : UILabel!
    @IBOutlet var lblCheckout : UILabel!
    @IBOutlet var lblDiscount : UILabel!
    @IBOutlet var btnApply : UIButton!
    @IBOutlet var tblCards : UITableView!
    @IBOutlet var viewCards : UIView!
    @IBOutlet var txtPromo : UITextField!
    
    @IBOutlet var lblHead : UILabel!
    @IBOutlet var lblSubHead : UILabel!
    @IBOutlet var lblVatHead : UILabel!
    @IBOutlet var lblTotalHead : UILabel!
    @IBOutlet var lblDiscountTitle : UILabel!
    @IBOutlet var lblSelectCard : UILabel!
    @IBOutlet var btnNewCard : UIButton!
    @IBOutlet var imgTypes : [UIImageView]!
    @IBOutlet var viewSummary : UIView!
    @IBOutlet var lblPaidTotal : UILabel!
    @IBOutlet var lblPrepaidTotal : UILabel!
    @IBOutlet var lblPaidDiscount : UILabel!
    @IBOutlet var lblSummary : UILabel!
    @IBOutlet var btnsubmit : UIButton!
    @IBOutlet var lblSelectOptions : UILabel!
    @IBOutlet var lblBook : UILabel!
    @IBOutlet var lblBook15 : UILabel!
    @IBOutlet var viewPayment : UIView!
    @IBOutlet var btnApple : UIButton!
    @IBOutlet var btnCard : UIButton!
    @IBOutlet var lblSelectPayment : UILabel!
    
    
    var paymentController: UIViewController? = nil
    var date = ""
    var time = ""
    var referanceId = ""
    var dateView : SelectDateViewController?
    var seletedCard = -1
    var discountApplied = -1
    var promoApplied = false
    var cards = [Cards]()
    var discountValue = 0.0
    var appointments : Appointments?
    var isReorde = false
    var isApplePayPaymentTrxn = false
    var isSucessStatus: Bool = false
    
    var paymentString = ""
    var discount_source = ""
    var discountObj:Discount?
    var payNowDiscountedAmount = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewPayment.isHidden = true
        
        setThemeColor()
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
        
        setInitialView()
        
        getCard()
        
        self.localizeView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.viewPayment.isHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnBack(_ sender: Any) {
      
        if referanceId != ""{
            dateView?.unlockTime(id: self.referanceId)
            self.navigationController?.popViewController(animated: false)
        }else{
            self.navigationController?.popViewController(animated: false)
            
        }
    }
    
    
    @IBAction func btnPromo(_ sender: Any) {
      
        if txtPromo.text == ""
        {
            let msg = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.enterPromoCode, comment: "")
        
            showAlert(title:"", subTitle: msg, sender: self)
      
            return
        }
       
        if  self.promoApplied == true{
            
            showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "promoAplied", comment: ""), sender: self)
           
            return
        }
        
        applyPromo()
    }
    
    
    @IBAction func btnAddNewCard(_ sender: Any) {
        seletedCard = -1
        // initilizePayment()
        viewPayment.isHidden = false
    }
    
    @IBAction func btnPayment(_ sender: UIButton) {
        
        if sender.tag == 0{
            DispatchQueue.main.async {
                self.initilizePayment()
            }
            
        }else if sender.tag == 1{
            DispatchQueue.main.async {
                self.initilizeApplePayment()
            }
            
        }
        else{
            viewPayment.isHidden = true
        }
        
        //        seletedCard = -1
        //       // initilizePayment()
        //        viewPayment.isHidden = false
        
    }
    
    
    @IBAction func btnCheckout(_ sender: Any) {
        lockTimeSlote()
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier:  stryBrdId.payment) as! PaymentViewController
        //        vc.amount = self.lblTotal.text?.replacingOccurrences(of: " SAR", with: "") ?? "0"
        //        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnTypes(_ sender: UIButton) {
       
        if sender.tag == 0{
            btnsubmit.setTitle( LocalizationSystem.sharedInstance.localizedStringForKey(key: "two", comment: ""), for: .normal)
            
            discountApplied = 0
            imgTypes[0].image = UIImage(named: checkIfNotMale() == true ? "circle_sel_girl" : "circle_sel_boy")
            imgTypes[1].image = UIImage(named: "circle_unsel")
            
            var totals = [Double]()
            
            if isReorde == true{
                for all in appointments?.services ?? []{
                    totals.append(Double(all.service_amount ?? "0.0")!)
                }
            }else{
            
                if let cartData = getCartData(){
                    for all in cartData{
                        totals.append(Double(all["price"] as? String ?? "0.0")!)
                    }
                }
            }
            
            let total = totals.reduce(0, +)
            
            let sum = totals.reduce(0, +)
            let vat = (15 * sum) / 100
            
            self.lblTotal.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(sum)"
            self.lblVat.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(vat)"
            
            let discount = (15 * total) / 100
            
            lblSub.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: sum - discount) )"
            
            
            //            let sum = total -  discount
            //
            //            let vat = (15 * sum) / 100
            
            
            //            let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            //            let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            //            let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "place_order", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
            //            //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
            //            let attributedString4 = NSMutableAttributedString(string:"\(sum) SAR", attributes:attrs4 as [NSAttributedString.Key : Any])
            //            attributedString3.append(attributedString4)
            //            lblCheckout.attributedText = attributedString3
            
            //            lblSub.text = "\(formatPrice(price: sum - discount) ) SAR"
            //            lblTotal.text =  "\(formatPrice(price: sum)) SAR"
            //            lblVat.text = "\(formatPrice(price: vat)) SAR"
            
            
        }else{
            btnsubmit.setTitle( LocalizationSystem.sharedInstance.localizedStringForKey(key: "one", comment: ""), for: .normal)
            
            discountApplied = 1
            imgTypes[0].image = UIImage(named: "circle_unsel")
            imgTypes[1].image = UIImage(named: checkIfNotMale() == true ? "circle_sel_girl" : "circle_sel_boy")
            //            self.lblTotal.text = lblPaidTotal.text
            //            self.lblVat.text = "\(0.0) SAR"
            
            var totals = [Double]()
            
            if isReorde == true{
                for all in appointments?.services ?? []{
                    totals.append(Double(all.service_amount ?? "0.0")!)
                }
            }else{
               
                if let cartData = getCartData(){
                    for all in cartData{
                        totals.append(Double(all["price"] as? String ?? "0.0")!)
                    }
                }
            }
            
            
            let total = totals.reduce(0, +)
      
            //MARK: using global dynamic value for  discount
           
            //   let discount = (15 * total) / 100
            let discount = (K.User.dicountValue * total) / 100
        
            let sum = total -  discount
            let vat = (15 * sum) / 100
           
            payNowDiscountedAmount = discount
            
            lblSub.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: sum - vat) )"
            lblTotal.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: sum))"
            lblVat.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: vat))"
            
            
            //            lblSub.text = "\(formatPrice(price: sum - vat) ) SAR"
            //            lblTotal.text =  "\(formatPrice(price: sum)) SAR"
            //            lblVat.text = "\(formatPrice(price: vat)) SAR"
            
            
        }
        
        if promoApplied == true, let discountObj{
          
            if discountValue != 0.0{
                
                let total = Double((lblTotal.text?.replacingOccurrences(of: "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) ", with: ""))!)
                
                //let vat = (discountValue * total!) / 100
               
                let vat = discountObj.discountedAmount ?? 0.0 // 16th May
               
                
                self.lblDiscount.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(vat)"
                
                let totals = total! - vat
                
                self.lblTotal.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(formatPrice(price: totals))"
           
                self.promoApplied = true
            }
        }
    }
}

//extension


