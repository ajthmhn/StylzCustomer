//
//  PaymentHandler_SummaryView.swift
//  StylezUser
//
//  Created by abcd on 30/05/2024.
//

import UIKit
import Urway
import PassKit


//MARK: - apple pay

extension SummeryViewController{
   
    
    
    func initilizeApplePayment(){
        isApplePayPaymentTrxn = true
        //test
        //        let terminalId = "stylz"
        //        let password = "stylz@URWAY"
        //        let merchantKey = "4d41678c4b6309ca358e689be3db9cf3ec33c0e317b4d9c737846d38ff3565fe"
        //        let url = "https://payments-dev.urway-tech.com/URWAYPGService/transaction/jsonProcess/JSONrequest"
        
        
        //live
        let terminalId = "stylz"
        let password = "st_9878@URWAY"
        let merchantKey = "03f296706cb7cae42eab87823a6741508b39a01cf7ae326350b7da27fd76acc0"
        let url = "https://payments.urway-tech.com/URWAYPGService/transaction/jsonProcess/JSONrequest"
        
        
        
        UWConfiguration(password: password , merchantKey: merchantKey , terminalID: terminalId , url: url )
        
        isSucessStatus = false
        
        UWInitialization(self)
        {
            (controller , result) in
            self.paymentController = controller
            guard let _ = self.paymentController
            else {
                self.presentAlert(resut: result)
                return
            }
        }
        
        isSucessStatus = false
        
        let amount = self.lblTotal.text?.replacingOccurrences(of: "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) ", with: "") ?? "0"
        
        
        let floatAmount = Double(amount ) ?? .zero
        
        let request = PKPaymentRequest()
        
        // change the name here to your merchant identifer name
        
        request.merchantIdentifier = "merchant.me.stylz.app"
        request.supportedNetworks = [.quicPay, .masterCard, .visa , .amex , .discover , .mada ]
        request.merchantCapabilities = .capability3DS
        
        request.countryCode = "SA"
        request.currencyCode = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: ""))"
        
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: " urway ",amount: NSDecimalNumber(floatLiteral: floatAmount) )]
        let controller = PKPaymentAuthorizationViewController(paymentRequest: request)
        if controller != nil
        {
            controller!.delegate = self
            present(controller!, animated: true, completion: nil)
        }
    }
    
}


//MARK: - urway

extension SummeryViewController{
    
    fileprivate func initializeSDK() {
        UWInitialization(self) { (controller , result) in
            self.paymentController = controller
            guard let nonNilController = self.paymentController else {
                self.presentAlert(resut: result)
                return
            }
            //print("initialSDK")
            self.navigationController?.pushViewController(nonNilController, animated: true)
        }
        
    }
    
   
    func initilizePayment(){
      
        isApplePayPaymentTrxn = false
        //test
        //        let terminalId = "stylz"
        //        let password = "stylz@URWAY"
        //        let merchantKey = "4d41678c4b6309ca358e689be3db9cf3ec33c0e317b4d9c737846d38ff3565fe"
        //        let url = "https://payments-dev.urway-tech.com/URWAYPGService/transaction/jsonProcess/JSONrequest"
        
        
        //live
        let terminalId = "stylz"
        let password = "st_9878@URWAY"
        let merchantKey = "03f296706cb7cae42eab87823a6741508b39a01cf7ae326350b7da27fd76acc0"
        let url = "https://payments.urway-tech.com/URWAYPGService/transaction/jsonProcess/JSONrequest"
        
        UWConfiguration(password: password , merchantKey: merchantKey , terminalID: terminalId , url: url )
        
        UWInitialization(self) { (controller , result) in
            self.paymentController = controller
            self.viewCards.isHidden = true
            guard let nonNilController = self.paymentController else {
                self.presentAlert(resut: result)
                return
            }
            //print("initialSDK")
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(nonNilController, animated: true)
        }
    }
}


extension SummeryViewController {
   
    func presentAlert(resut: paymentResult) {
        var displayTitle: String = ""
        var key: mandatoryEnum = .amount
        
        switch resut {
        case .mandatory(let fields):
            key = fields
        default:
            break
        }
        
        switch  key {
        case .amount:
            displayTitle = "Amount"
        case.country:
            displayTitle = "Country"
        case.action_code:
            displayTitle = "Action Code"
        case.currency:
            displayTitle = "Currency"
        case.email:
            displayTitle = "Email"
        case.trackId:
            displayTitle = "TrackID"
        case .tokenID:
            displayTitle = "TokenID"
        case .cardOperation:
            displayTitle = "Token Operation"
        }
        
        let alert = UIAlertController(title: "Alert", message: "Check \(displayTitle) Field", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SummeryViewController : PKPaymentAuthorizationViewControllerDelegate {
  
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        if isSucessStatus == true{
            DispatchQueue.main.async {
                //print("~ did authrorize payamnet2: initializind  sdk")
                
                self.initializeSDK()
            }
        }
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        self.paymentString = UWInitializer.generatePaymentKey(payment: payment) as String
        isSucessStatus = true
        
        //print("~ did authrorize payamnet: \(payment)")
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}


extension SummeryViewController: Initializer {
    
    func prepareModel() -> UWInitializer {
        
        let amount = self.lblTotal.text?.replacingOccurrences(of: "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) ", with: "") ?? "0"
        let model = UWInitializer.init(amount: amount,
                                       
                                       email: getUserDetails()?["email"] as? String ?? "",
                                       zipCode: "",
                                       currency: "SAR",
                                       country: "SA",//12
                                       actionCode: seletedCard == -1 ? "1" : "1" ,
                                       trackIdCode: referanceId,
                                       udf1: "",
                                       udf2: "",
                                       //isApplePayPaymentTrxn ? "ApplePay" : ""
                                       udf3:  "" ,
                                       //isApplePayPaymentTrxn ? paymentString : ""
                                       //                                     udf5: paymentString,
                                       udf4: isApplePayPaymentTrxn ? "ApplePay" : "" ,
                                       udf5: isApplePayPaymentTrxn ? paymentString as NSString : "",
                                       city: "",
                                       address: "",
                                       createTokenIsEnabled: true ,
                                       merchantIP: "" ,
                                       cardOper: seletedCard == -1 ? "A" : "A/U/D", merchantidentifier : "merchant.me.stylz.app",
                                       tokenizationType: "1")
        
        
        return model
        
    }
    
    func didPaymentResult(result: paymentResult, error: Error?, model: PaymentResultData?) {
        switch result {
            
        case .sucess:
            
            self.placeOrder(paymentID: model?.paymentID ?? "", transactionId: model?.transID ?? "")
            
            //            DispatchQueue.global(qos: .userInitiated).async {
            //                self.createCard(cardToken: model?.tokenID ?? "", cardNumber: model?.maskedPan ?? "", cardBrand: model?.cardBrand ?? "")
            //            }
        case.failure:
            DispatchQueue.main.async {
                
                let alertController = UIAlertController(title: "Payment Failed!", message: "Please try again later", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self.navigationController?.popViewController(animated: true)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            
            
            
        case .mandatory(let fieldName):
            //print(fieldName)
            break
        }
    }
    
    func navigateTOReceptPage(model: PaymentResultData?) {
        //        self.paymentController?.navigationController?.popViewController(animated: true)
        //        //print("Navigate to receipt")
        //        let controller = ReceptConfiguration.setup()
        //        controller.model = model
        //        controller.modalPresentationStyle = .overFullScreen
        //        self.present(controller, animated: true, completion: nil)
    }
    
}
