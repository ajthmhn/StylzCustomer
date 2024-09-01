//
//  CancelSubscriptionViewController.swift
//  StylezUser
//
//  Created by MACBOOK on 3/7/24.
//

import UIKit

class CancelSubscriptionViewController: UIViewController {

    @IBOutlet var btnRenewSubscription_Outlet: UIButtonX!
    @IBOutlet var btnmoveToHome_Outlet: UIButtonX!

    @IBOutlet var lblWeARESorry: UILabel!
    @IBOutlet var lblCAncelDEscription: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

   setThemeColor()
        localizeText()
    }
    

    @IBAction func onClick_BackToHomePage(_ sender: UIButton) {
   moveToHomePage()
    }
    
    @IBAction func onClick_RenewBtn(_ sender: UIButton) {
  
    }
    
}

//MARK: - UI
extension CancelSubscriptionViewController{

    func setThemeColor(){
        
        btnRenewSubscription_Outlet.backgroundColor = getThemeColor()
        
        btnRenewSubscription_Outlet.shadowColor = getThemeColor().withAlphaComponent(0.7)
    }
    
    func localizeText(){
        lblWeARESorry.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.weAreSorry, comment: "")
      
        lblCAncelDEscription.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.cancelSubscriptionText, comment: "")
      
        btnRenewSubscription_Outlet.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.reactivateSubscription, comment: ""), for: .normal)

        btnmoveToHome_Outlet.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.backToHomePage, comment: ""), for: .normal)

    }
}

//MARK: - Navigation
extension CancelSubscriptionViewController{
    
    func moveToHomePage(){
        let stry = UIStoryboard(name: "Main", bundle: nil)
  
        let vc = stry.instantiateViewController(withIdentifier: "root_vc")
        vc.modalPresentationStyle = .fullScreen
     
        self.present(vc, animated: true)
        }
}
