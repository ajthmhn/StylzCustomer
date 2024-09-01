//
//  MyPlanViewController.swift
//  StylezUser
//
//  Created by MACBOOK on 3/7/24.
//

import UIKit

class MyPlanViewController: BaseViewController {
    
    @IBOutlet var myPlan_tableView: UITableView!
    
    @IBOutlet var viewlogo: UIView!
    @IBOutlet var btnViewPlanFeature_Outlet: UIButtonX!
    @IBOutlet var btnCancelPlan_Outlet: UIButtonX!
  
    @IBOutlet var lbl_title: UILabel!
   
    @IBOutlet var lbl_renewDate: UILabel!
   
    @IBOutlet var lbl_premiumPlan: UILabel!
    @IBOutlet var lbl_monthly: UILabel!
    @IBOutlet var lbl_PremiumHistory: UILabel!
    @IBOutlet var lbl_StylePremium: UILabel!
    @IBOutlet var lbl_susbscriptionAutomaticallyRenewOn: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
      
        setThemeColor()
        localizeText()
        configTableView()
        
    }
    
    
    @IBAction func onClick_CancelSubscriptionBtn(_ sender: UIButton) {
        showCancelSubcriptionAlert()
    }
    @IBAction func onClick_ViewPlanFeatureBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func onClick_BackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated:true)
    }
    
}

//MARK: - table view

extension MyPlanViewController:UITableViewDelegate, UITableViewDataSource{
    
    
    func configTableView(){
        let nib = UINib(nibName: "PlanHistoryTableViewCell", bundle: nil)
        myPlan_tableView.register(nib, forCellReuseIdentifier: "PlanHistoryTableViewCell")
        myPlan_tableView.dataSource = self
        myPlan_tableView.delegate = self
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanHistoryTableViewCell", for: indexPath) as? PlanHistoryTableViewCell else { return UITableViewCell() }
        cell.localizeText()
        return cell
    }
    
    
}

//MARK: - UI
extension MyPlanViewController{

    func setThemeColor(){
        viewlogo.backgroundColor = getThemeColor()
        btnViewPlanFeature_Outlet.backgroundColor = getThemeColor()
    }
    
    
    func  localizeText(){
        
        lbl_premiumPlan.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.premiumPlan, comment: "")
        lbl_monthly.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.monthly, comment: "")
        lbl_PremiumHistory.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.subscripitonHistory, comment: "")
        lbl_StylePremium.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.stylPremium, comment: "")
        lbl_susbscriptionAutomaticallyRenewOn.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.subscriptionWillAutomaticallyRenewOn, comment: "")

        
        lbl_title.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.myPlan, comment: "")
        
        //.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "old_password", comment: "")

        btnCancelPlan_Outlet.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.cancelPremium, comment: ""), for: .normal)
        
        
        btnViewPlanFeature_Outlet.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.viewPlanFeature, comment: ""), for: .normal)
    
    }
}


//MARK: - navigation and alert

extension MyPlanViewController{
    
    func showCancelSubcriptionAlert(){
       
        let title = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.areYouSure, comment: "")
        let subtitle = LocalizationSystem.sharedInstance.localizedStringForKey(key:K.MYStrings.cancelSubscriptionAlertText, comment: "")
        let staySubscribed = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.staySubscribed, comment: "")
        let yes = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.yes, comment: "")

        
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        
        let staySubscribedAction = UIAlertAction(title: staySubscribed , style:UIAlertAction.Style.default) {                     UIAlertAction in
        }
        
        let CancelAction = UIAlertAction(title: yes, style:UIAlertAction.Style.default) {                     UIAlertAction in
            Bean.sharedIntance.set_boolValue(value: false, key: K.UserDefaultsKeys.isSubscribed)
            K.User.isSubscribed = false
            self.moveToCanceledSubscriptionView()
            
        }
        
        CancelAction.setValue(UIColor.systemPink, forKey: "titleTextColor")
        
        alertController.addAction(CancelAction)
        alertController.addAction(staySubscribedAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func moveToCanceledSubscriptionView()
    {
        let stry = UIStoryboard(name: "Profile", bundle: nil)
        
        let vc = stry.instantiateViewController(withIdentifier: stryBrdId.cancelPlan) as! CancelSubscriptionViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
}
