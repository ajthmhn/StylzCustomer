//
//  GetPremimumViewController.swift
//  StylezUser
//
//  Created by MACBOOK on 3/7/24.
//

import UIKit

class GetPremimumViewController: UIViewController {
    
    @IBOutlet var imgArray: [UIImageView]!
    @IBOutlet var btnPremimun_Outlet: UIButtonX!
    @IBOutlet var lblPlus: UILabel!
   
    @IBOutlet var lblSARPerMonthCAncelAnytime: UILabel!
    @IBOutlet var lblFreeForSevenDaysCancelAnytime: UILabel!
    @IBOutlet var lblGetPremimum: UILabel!
    @IBOutlet var lblstyle: UILabel!
    @IBOutlet var lblPremium: UILabel!
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       setThemeColor()
        localizeText()
    }
    
    @IBAction func onClick_BackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated:true)
    }

    
    @IBAction func onClick_GetSubcriptionBtn(_ sender: UIButton) {
      moveTo()
    }

    
}

//MARK: - UI
extension GetPremimumViewController{
    
    
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
       // lblstyle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.premiumPlan, comment: "")
      
        btnPremimun_Outlet.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.getPremiumPlan, comment: ""), for: .normal)
}
  
}

//MARK: - navigation
extension GetPremimumViewController{
    
    func moveTo()
    {
        let stry = UIStoryboard(name: "Profile", bundle: nil)
       
        let vc = stry.instantiateViewController(withIdentifier: stryBrdId.subscription2) as! GetPremimun2ViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
    
}
