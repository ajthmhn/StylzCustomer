//
//  ProfileViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 16/08/23.
//

import UIKit
import StylesWebKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet var imgTypes: [UIImageView]!
    @IBOutlet var viewLogin: [UIView]!
    @IBOutlet var lblSignout: UILabel!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var lblAccountHead: UILabel!
    @IBOutlet var lblSettingsHead: UILabel!
    @IBOutlet var lblProfile: UILabel!
    @IBOutlet var lblWallet: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblHistory: UILabel!
    @IBOutlet var lblNOtifications: UILabel!
    @IBOutlet var lblGenderHead: UILabel!
    @IBOutlet var lblLanguageHead: UILabel!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var lblLanguage: UILabel!
    @IBOutlet var lblSubscription: UILabel!
    
    @IBOutlet var imgArrow: [UIImageView]!
    @IBOutlet var imgLogout: UIImageView!
  
    @IBOutlet var imgSubscription: UIImageView!
    @IBOutlet var imgPremimum: UIImageView!
 
    @IBOutlet var lblAccountDelete: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProfileViewImages()
        
        setLanguageLabel()
        setLanguage()
        
        setGenderDetails()
        
        setUserPremimunView()
        
        updateViewLoggedInOrOutState()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUserPremimunView()
    }
    

    @IBAction func btnSelect(_ sender: UIButton) {
        switch sender.tag {
            
        case 0:
            moveTo(controllerIdentifier: stryBrdId.editProfile, withProfileStryBoard: false)
            
        case 2:
            moveTo(controllerIdentifier: stryBrdId.address, withProfileStryBoard: true)
            
        case 1:
            moveTo(controllerIdentifier: stryBrdId.wallet, withProfileStryBoard: true)
            
        case 3:
            moveTo(controllerIdentifier: stryBrdId.history, withProfileStryBoard: true)
            
        case 4:
            moveTo(controllerIdentifier: stryBrdId.notifications, withProfileStryBoard: true)
            
        case 5,6:
            moveToGenderOrLanguageView(tag: sender.tag)
            
        case 8:
            
            K.User.isSubscribed ?
            moveTo(controllerIdentifier: stryBrdId.myPlan, withProfileStryBoard: true)
            :
            moveTo(controllerIdentifier: stryBrdId.subscription1, withProfileStryBoard: true)
            
            
        case 7:
            hanldeLogOut()
         
            
        case 9:
            showDeleteAccountAlert()
       
        default:
            print("")
            
        }
    }
}


//MARK: - other
extension ProfileViewController
{
   
    func moveToGenderOrLanguageView(tag:Int){
        let stry = UIStoryboard(name: "Profile", bundle: nil)
        let vc = stry.instantiateViewController(withIdentifier:  stryBrdId.options) as! SelectOptionsViewController
        
        vc.modalPresentationStyle = .popover
        if tag == 5{
            vc.isGender = true
        }else{
            vc.isGender = false
        }
        self.present(vc, animated: true)
    }
    
    func moveTo(controllerIdentifier:String, withProfileStryBoard:Bool)
    {
        var stry = self.storyboard
        if withProfileStryBoard{
            stry = UIStoryboard(name: "Profile", bundle: nil)
        }
        guard let vc = stry?.instantiateViewController(withIdentifier: controllerIdentifier) else { return  }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



//MARK: - Delete account

extension ProfileViewController{
    
    func showDeleteAccountAlert(){
        
     
        let confirm = LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirm", comment: "")
        let cancel = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancel", comment: "")
        let areYouSure = LocalizationSystem.sharedInstance.localizedStringForKey(key: "YouSure", comment: "")
        let youWantToDeleteAcc = LocalizationSystem.sharedInstance.localizedStringForKey(key: "WantToDelete", comment: "")
        let alertTitle = LocalizationSystem.sharedInstance.localizedStringForKey(key: "DeleteAccount2", comment: "")
     
        
      
        let alertController = UIAlertController(title: alertTitle, message: youWantToDeleteAcc, preferredStyle: UIAlertController.Style.alert)
  
        let okAction = UIAlertAction(title: confirm, style: UIAlertAction.Style.destructive) {
            (result : UIAlertAction) -> Void in
        
            self.deleteAcc()
            
        }
        
        let deleteAction = UIAlertAction(title: cancel, style: UIAlertAction.Style.default) {
             (result : UIAlertAction) -> Void in
             //print("OK")
         }
        
         alertController.addAction(deleteAction)
         alertController.addAction(okAction)
     
         self.present(alertController, animated: true, completion: nil)
    }
    
    func deleteAcc(){

        StylzAPIFacade.shared.deleteAccount { ares in
            //print("acc deleted: \(ares?.json?["message"])")
        }
        
        clearCart()
        deleteUserDetails()
        StylzAPIFacade.shared.resetSession()
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "root_vc")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
}
