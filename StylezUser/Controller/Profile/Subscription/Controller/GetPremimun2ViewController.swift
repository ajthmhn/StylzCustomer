//
//  GetPremimun2ViewController.swift
//  StylezUser
//
//  Created by MACBOOK on 3/7/24.
//

import UIKit

class GetPremimun2ViewController: UIViewController {
    
    @IBOutlet var imgArray: [UIImageView]!
    @IBOutlet var btnPremimun_Outlet: UIButtonX!
    @IBOutlet var lblPlus: UILabel!
   
    @IBOutlet var lblSARPerMonthCAncelAnytime: UILabel!
    @IBOutlet var lblFreeForSevenDaysCancelAnytime: UILabel!
    @IBOutlet var lblGetPremimum: UILabel!
    @IBOutlet var lblGetSevendaysFRee: UILabel!
   
    @IBOutlet var lblstyle: UILabel!
    @IBOutlet var lblPremium: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setThemeColor()
localizeText()
    }
    
    @IBAction func onClick_BackBtn(_ sender: UIButton) {
        //print("onlcik_ back btn")
        moveToProfileVew()
    }
    
    
    @IBAction func onClick_GetSubcriptionBtn(_ sender: UIButton) {
        
        Bean.sharedIntance.set_boolValue(value: true, key: K.UserDefaultsKeys.isSubscribed)
        K.User.isSubscribed = true
        showSubcriptionAlert()
    }
}

//MARK: - UI
extension GetPremimun2ViewController{

    
    
    func setThemeColor(){
        
        for img in imgArray{
            img.tintColor = getThemeColor()
        }
        
        lblPlus.textColor = getThemeColor()
        
        btnPremimun_Outlet.backgroundColor = getThemeColor()
        
        btnPremimun_Outlet.shadowColor = getThemeColor().withAlphaComponent(0.7)
    }
   
    func localizeText(){
        
        lblSARPerMonthCAncelAnytime.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.sarPErMOnthCANcelANytime, comment: "")
        
        lblFreeForSevenDaysCancelAnytime.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.SevendayFreeCancelAnytime, comment: "")
       
        lblGetPremimum.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.getPremium, comment: "")
       
        lblGetSevendaysFRee.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.getSevenDaysForFree, comment: "")
       
        // lblstyle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.premiumPlan, comment: "")
      
        btnPremimun_Outlet.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.getPremiumPlan, comment: ""), for: .normal)
}
   
}

//MARK: - navigation and alert

extension GetPremimun2ViewController{
    
    func moveTo()
    {
        let stry = UIStoryboard(name: "Profile", bundle: nil)
        
        let vc = stry.instantiateViewController(withIdentifier: stryBrdId.myPlan) as! MyPlanViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func moveToProfileVew(){
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        var count = 1 // for checking purpose
        for aViewController in viewControllers {
            //print("count: \(count), -> \(aViewController)")
            count += 1
            if aViewController is ProfileViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    
    
    func showSubcriptionAlert(){
       
        let title = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.youAreAllSet, comment: "")
        let subtitle = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.purchaseSuccesful, comment: "")
        
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "ok", comment: ""), style:UIAlertAction.Style.default) {                     UIAlertAction in
            
            self.moveToProfileVew()
            
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

